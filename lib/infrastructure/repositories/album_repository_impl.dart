import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/domain/repositories/album_repository.dart';
import 'package:media_vault/infrastructure/extensions/firebase_extensions.dart';
import 'package:media_vault/infrastructure/models/album_model.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final FirebaseFirestore firestore;
  AlbumRepositoryImpl({required this.firestore});

  @override
  Future<Either<MediaFailure, Unit>> create(String title) async {
    try {
      final userDoc = await firestore.userDocument();

      // go 'reverse' from domain to infrastructure
      final albumModel = AlbumModel.fromEntity(Album.empty().copyWith(title: title));

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

      // go 'reverse' from domain to infrastructure
      final albumModel = AlbumModel.fromEntity(album);

      await userDoc.albumCollection.doc(albumModel.id).update(albumModel.copyWith(updatedAt: FieldValue.serverTimestamp()).toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<MediaFailure, Unit>> delete(UniqueID id) async {
    try {
      final userDoc = await firestore.userDocument();

      await userDoc.albumCollection.doc(id.toString()).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Stream<Either<MediaFailure, List<Album>>> watchAll() async* {
    final userDoc = await firestore.userDocument();

    yield* userDoc.albumCollection
        .snapshots()
        .map((snapshot) => right<MediaFailure, List<Album>>(snapshot.docs.map((doc) => AlbumModel.fromFirestore(doc).toEntity()).toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        print(e);
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
