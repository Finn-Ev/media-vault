import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/extensions/firebase_extensions.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';
import 'package:media_vault/features/albums/domain/repositories/album_repository.dart';
import 'package:media_vault/features/albums/infrastructure/models/album_model.dart';
import 'package:media_vault/features/assets/domain/repositories/asset_repository.dart';
import 'package:media_vault/features/assets/infrastructure/model/asset_model.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final AssetRepository assetRepository;

  AlbumRepositoryImpl({required this.firestore, required this.storage, required this.assetRepository});

  @override
  Future<Either<MediaFailure, Unit>> create(String title) async {
    try {
      final userDoc = await firestore.userDocument();

      // go 'reverse' from domain to infrastructure
      var albumModel = AlbumModel.fromEntity(Album.empty().copyWith(title: title));

      await userDoc.albumCollection.doc(albumModel.id).set(albumModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> update(Album album) async {
    try {
      final userDoc = await firestore.userDocument();

      final albumModel = AlbumModel.fromEntity(album);

      await userDoc.albumCollection
          .doc(albumModel.id)
          .update(albumModel.copyWith(updatedAt: FieldValue.serverTimestamp()).toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> createTrash() async {
    try {
      final userDoc = await firestore.userDocument();

      var albumModel = AlbumModel.fromEntity(Album.empty());

      albumModel = albumModel.copyWith(id: trashAlbumId);

      await userDoc.albumCollection.doc(albumModel.id).set(albumModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> moveToTrash(String albumId) async {
    try {
      final userDoc = await firestore.userDocument();

      final assetDocsToMoveToTrash = await userDoc.collection("albums/$albumId/assets").get();

      for (final assetDoc in assetDocsToMoveToTrash.docs) {
        assetRepository.moveToTrash(
          AssetModel.fromFirestore(assetDoc).copyWith(modifiedAt: DateTime.now()).toEntity(),
          albumId,
        );
      }

      // set the deleted-field to true
      await userDoc.albumCollection.doc(albumId).update({'deleted': true});

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> deleteAllPermanently() async {
    try {
      final userDoc = await firestore.userDocument();

      final snapshot = await userDoc.albumCollection.get();

      final allAlbums = snapshot.docs.map((doc) => AlbumModel.fromFirestore(doc).toEntity()).toList();

      for (final album in allAlbums) {
        if (album.id != trashAlbumId) {
          await moveToTrash(album.id);
          await userDoc.albumCollection.doc(album.id).delete();
        }
      }

      // empty the trash
      final trashAssets = await userDoc.collection('albums/$trashAlbumId/assets').get();
      for (final assetDoc in trashAssets.docs) {
        await assetRepository.deletePermanently(AssetModel.fromFirestore(assetDoc).toEntity());
      }

      return right(unit);
    } catch (e) {
      if (e is FirebaseException) {
        if (kDebugMode) {
          print(e);
        }
        if (e.code.contains('permission-denied') || e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermissions());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Stream<Either<MediaFailure, List<Album>>> watchAll() async* {
    final userDoc = await firestore.userDocument();

    yield* userDoc.albumCollection
        .snapshots()
        .map((snapshot) => right<MediaFailure, List<Album>>(
            snapshot.docs.map((doc) => AlbumModel.fromFirestore(doc).toEntity()).toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (kDebugMode) {
          print(e);
        }
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
