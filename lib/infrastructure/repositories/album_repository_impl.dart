import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/album_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/domain/repositories/album_repository.dart';
import 'package:media_vault/infrastructure/extensions/firebase_extensions.dart';
import 'package:media_vault/infrastructure/models/album_model.dart';

class AlbumRepositoryImpl extends AlbumRepository {
  final FirebaseFirestore firestore;
  AlbumRepositoryImpl({required this.firestore});

  @override
  Future<Either<AlbumFailure, Unit>> create(Album album) async {
    try {
      final userDoc = await firestore.userDocument();

      // go 'reverse' from domain to infrastructure
      final todoModel = AlbumModel.fromEntity(album);

      await userDoc.albumCollection.doc(todoModel.id).set(todoModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<AlbumFailure, Unit>> update(Album album) async {
    try {
      final userDoc = await firestore.userDocument();

      // go 'reverse' from domain to infrastructure
      final todoModel = AlbumModel.fromEntity(album);

      await userDoc.albumCollection.doc(todoModel.id).update(todoModel.copyWith(updatedAt: todoModel.updatedAt).toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.code == 'permission-denied' || e.code == 'PERMISSION_DENIED') {
        return left(InsufficientPermissions());
      }
      return left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<AlbumFailure, Unit>> delete(UniqueID id) async {
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
  Stream<Either<AlbumFailure, List<Album>>> watchAll() async* {
    final userDoc = await firestore.userDocument();

    // right side listen on albums collection
    // yield* userDoc.albumCollection
    yield* userDoc.albumCollection
        .snapshots()
        .map((snapshot) => right<AlbumFailure, List<Album>>(snapshot.docs.map((doc) => AlbumModel.fromFirestore(doc).toEntity()).toList()))
        .handleError((e) {
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
