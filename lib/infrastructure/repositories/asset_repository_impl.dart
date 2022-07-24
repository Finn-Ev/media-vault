import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:media_vault/infrastructure/extensions/firebase_extensions.dart';
import 'package:media_vault/infrastructure/models/asset_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as asset_picker;

class AssetRepositoryImpl extends AssetRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  AssetRepositoryImpl({required this.firestore, required this.storage});

  @override
  Future<Either<MediaFailure, Unit>> upload(asset_picker.AssetEntity asset, UniqueID albumId) async {
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

      // final file = await asset.file; // always jpg
      final file = await asset.originFile; // original file ending
      print("uploading asset: ${file}");

      await storage.ref(userDoc.id).child(const Uuid().v4()).putFile(file!).then(
        (taskSnapshot) async {
          final downloadUrl = await taskSnapshot.ref.getDownloadURL();
          final assetModel = AssetModel.fromEntity(customAssetEntity.copyWith(url: downloadUrl));
          await userDoc.collection('albums/$albumId/assets').doc(assetModel.id).set(assetModel.toMap());
        },
      ).catchError((e) => print("upload-error: " + e.toString()));
      // .whenComplete(() => file.delete());

      return right(unit);
    } on FirebaseException catch (error) {
      print("upload-error: " + error.toString());
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> delete(Asset assetToDelete, UniqueID albumId) async {
    try {
      final userDoc = await firestore.userDocument();

      await userDoc.collection('albums/$albumId/assets').doc(assetToDelete.id.toString()).delete();

      await storage.refFromURL(assetToDelete.url).delete();

      return right(unit);
    } on FirebaseException catch (error) {
      print("delete-error: " + error.toString());
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> copy(Asset assetToCopy, UniqueID destinationAlbumId) async {
    try {
      final userDoc = await firestore.userDocument();

      // todo: just upload the asset again to the destination album

      return right(unit);
    } on FirebaseException catch (error) {
      print("delete-error: " + error.toString());
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> move(Asset assetToMove, UniqueID sourceAlbumId, UniqueID destinationAlbumId) async {
    try {
      final userDoc = await firestore.userDocument();

      await userDoc.collection('albums/$sourceAlbumId/assets').doc(assetToMove.id.toString()).delete();

      await storage.refFromURL(assetToMove.url).delete();

      // todo: just upload the asset again to the destination album

      return right(unit);
    } on FirebaseException catch (error) {
      print("delete-error: " + error.toString());
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> export(Asset assetToExport) async {
    try {
      final assetMetaData = await storage.refFromURL(assetToExport.url).getMetadata();

      final fileEnding = assetMetaData.contentType!.split('/').last;

      final tempDir = await getTemporaryDirectory();

      final path = '${tempDir.path}/${assetToExport.id}.$fileEnding';

      await Dio().download(assetToExport.url, path);

      if (assetToExport.isVideo) {
        await GallerySaver.saveVideo(path);
      } else {
        await GallerySaver.saveImage(path);
      }

      File(path).delete();
      return right(unit);
    } catch (error) {
      print("export-error: " + error.toString());
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
        .handleError(
      (error) {
        print("observer-error: " + error.toString());
        if (error is FirebaseException) {
          if (error.code.contains('permission-denied') || error.code.contains("PERMISSION_DENIED")) {
            return left(InsufficientPermissions());
          } else {
            return left(UnexpectedFailure());
          }
        } else {
          return left(UnexpectedFailure());
        }
      },
    );
  }
}
