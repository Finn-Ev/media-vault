import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:media_vault/infrastructure/extensions/firebase_extensions.dart';
import 'package:media_vault/infrastructure/models/asset_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as asset_picker;

class AssetRepositoryImpl extends AssetRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  AssetRepositoryImpl({required this.firestore, required this.storage});

  @override
  Future<Either<MediaFailure, Unit>> upload(asset_picker.AssetEntity asset, String albumId) async {
    try {
      final userDoc = await firestore.userDocument();

      // await Future.delayed(const Duration(seconds: 2));
      // final file = await asset.file; // always jpg
      File? file = await asset.originFile; // original file ending

      if (file == null) {
        if (kDebugMode) {
          print('[AssetRepositoryImpl]: File is null');
        }
        return Left(UnexpectedFailure());
      }

      Asset newAsset = Asset(
        id: const Uuid().v4(),
        albumId: albumId,
        uploadedAt: DateTime.now(),
        modifiedAt: DateTime.now(),
      );

      if (asset.duration > 0) {
        newAsset = newAsset.copyWith(duration: asset.duration, isVideo: true);
      }

      if (newAsset.isVideo) {
        // if [newAsset] is a video, generate a thumbnail and save it to firebase storage
        final thumbnail = await VideoThumbnail.thumbnailFile(
          video: file.path,
          thumbnailPath: (await getTemporaryDirectory()).path,
          imageFormat: ImageFormat.PNG,
        );

        await storage.ref('thumbnails').child(const Uuid().v4()).putFile(File(thumbnail!)).then(
          (taskSnapshot) async {
            final thumbnailUrl = await taskSnapshot.ref.getDownloadURL();
            newAsset = newAsset.copyWith(thumbnailUrl: thumbnailUrl);
          },
        );
      }

      // then we upload the video itself to firebase storage
      await storage.ref('assets').child(const Uuid().v4()).putFile(file).then(
        (taskSnapshot) async {
          final downloadUrl = await taskSnapshot.ref.getDownloadURL();
          final assetModel = AssetModel.fromEntity(newAsset.copyWith(url: downloadUrl));
          await userDoc.collection('albums/$albumId/assets').doc(assetModel.id).set(assetModel.toMap());
        },
      ).catchError((e) {
        if (kDebugMode) {
          print("upload-error: $e");
        }
      });

      return right(unit);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print("upload-error: $error");
      }
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> deletePermanently(Asset assetToDelete) async {
    try {
      final userDoc = await firestore.userDocument();

      await userDoc.collection('albums/$trashAlbumId/assets').doc(assetToDelete.id.toString()).delete();

      await storage.refFromURL(assetToDelete.url).delete();

      if (assetToDelete.thumbnailUrl.isNotEmpty) {
        await storage.refFromURL(assetToDelete.thumbnailUrl).delete();
      }

      return right(unit);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print("delete-error: $error");
      }
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> move(
      Asset assetToMove, String sourceAlbumId, String destinationAlbumId) async {
    try {
      final userDoc = await firestore.userDocument();

      // just delete the asset from the source album and add it to the destination album
      // the storage-file stays untouched
      await userDoc.collection('albums/$sourceAlbumId/assets').doc(assetToMove.id).delete();

      await userDoc.collection('albums/$destinationAlbumId/assets').doc(assetToMove.id).set(
            AssetModel.fromEntity(assetToMove)
                .copyWith(albumId: destinationAlbumId, modifiedAt: DateTime.now())
                .toMap(),
          );

      final albumData = await userDoc.collection('albums').doc(destinationAlbumId).get();
      final albumIsMarkedAsDeleted = albumData.data()!['deleted'];

      if (albumIsMarkedAsDeleted) {
        await userDoc.albumCollection.doc(destinationAlbumId).update({'deleted': false});
      }

      return right(unit);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print("delete-error: $error");
      }
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> moveToTrash(Asset assetToMove, String sourceAlbumId) async {
    try {
      final userDoc = await firestore.userDocument();

      // just delete the asset from the source album and add it to the destination album
      // the storage-file stays untouched
      await userDoc.collection('albums/$sourceAlbumId/assets').doc(assetToMove.id).delete();

      await userDoc.collection('albums/$trashAlbumId/assets').doc(assetToMove.id).set(
            // don't update albumId, otherwise we can't move it back to the original album
            AssetModel.fromEntity(assetToMove.copyWith(
              modifiedAt: DateTime.now(),
            )).toMap(),
          );

      return right(unit);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print("delete-error: $error");
      }
      if (error.code == 'permission-denied' || error.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> copy(Asset assetToCopy, String destinationAlbumId) async {
    try {
      final userDoc = await firestore.userDocument();

      // basically just upload the asset from scratch to the destination album
      // this is necessary because the copy of the asset has to be fully independent of the origin-asset
      // otherwise the origin-asset-file would be deleted, for example when the copy is deleted, as they would share the same file-path
      final assetMetaData = await storage.refFromURL(assetToCopy.url).getMetadata();

      final fileEnding = assetMetaData.contentType!.split('/').last;

      final tempDir = await getTemporaryDirectory();

      final path = '${tempDir.path}/${assetToCopy.id}.$fileEnding';

      await Dio().download(assetToCopy.url, path);

      await storage.ref('assets').child(const Uuid().v4()).putFile(File(path)).then(
        (taskSnapshot) async {
          final downloadUrl = await taskSnapshot.ref.getDownloadURL();
          final assetModel =
              AssetModel.fromEntity(assetToCopy.copyWith(url: downloadUrl, modifiedAt: DateTime.now()));
          await userDoc.collection('albums/$destinationAlbumId/assets').doc(const Uuid().v4()).set(
                assetModel.toMap(),
              );
        },
      ).catchError((e) {
        if (kDebugMode) {
          print("upload-error: $e");
        }
      });

      File(path).delete();

      return right(unit);
    } on FirebaseException catch (error) {
      if (kDebugMode) {
        print("delete-error: $error");
      }
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
      if (kDebugMode) {
        print("export-error: $error");
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
        .map((snapshot) => right<MediaFailure, List<Asset>>(
            snapshot.docs.map((doc) => AssetModel.fromFirestore(doc).toEntity()).toList()))
        .handleError(
      (error) {
        if (kDebugMode) {
          print("observer-error: $error");
        }
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
