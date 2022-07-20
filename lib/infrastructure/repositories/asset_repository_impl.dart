import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:media_vault/infrastructure/extensions/firebase_extensions.dart';
import 'package:media_vault/infrastructure/models/asset_model.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as asset_picker;

class AssetRepositoryImpl extends AssetRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  AssetRepositoryImpl({required this.firestore, required this.storage});

  @override
  Future<Either<MediaFailure, Unit>> uploadAsset(asset_picker.AssetEntity asset, UniqueID albumId) async {
    try {
      final userDoc = await firestore.userDocument();

      final customAssetEntity = Asset(
        id: UniqueID.fromString(const Uuid().v4()),
        url: "",
        isVideo: asset.duration > 0,
        duration: asset.duration,
        createdAt: asset.createDateTime,
        uploadedAt: DateTime.now(),
      );

      final file = File((await asset.file)!.path);

      await storage
          .ref(userDoc.id)
          .child(const Uuid().v4())
          .putFile(file)
          .then(
            (taskSnapshot) async {
              final downloadUrl = await taskSnapshot.ref.getDownloadURL();
              final assetModel = AssetModel.fromEntity(customAssetEntity.copyWith(url: downloadUrl));
              await userDoc.collection('albums/$albumId/assets').doc(assetModel.id).set(assetModel.toMap());
            },
          )
          .catchError((e) => print(e))
          .whenComplete(() => file.delete());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> delete(List<Asset> assetsToDelete, UniqueID albumId) async {
    try {
      final userDoc = await firestore.userDocument();

      for (final asset in assetsToDelete) {
        await userDoc.collection('albums/$albumId/assets').doc(asset.id.toString()).delete();

        await storage.refFromURL(asset.url).delete();
      }

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Stream<Either<MediaFailure, List<Asset>>> watchAlbum(albumId) async* {
    final userDoc = await firestore.userDocument();

    yield* userDoc
        .collection("albums/$albumId/assets")
        .snapshots()
        .map((snapshot) => right<MediaFailure, List<Asset>>(snapshot.docs.map((doc) => AssetModel.fromFirestore(doc).toEntity()).toList()))
        .handleError((e) {
      print(e);
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') || e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    });
  }
}