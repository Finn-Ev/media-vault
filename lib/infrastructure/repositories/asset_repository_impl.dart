import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:media_vault/infrastructure/extensions/firebase_extensions.dart';
import 'package:media_vault/infrastructure/models/asset_model.dart';

class AssetRepositoryImpl extends AssetRepository {
  final FirebaseFirestore firestore;
  AssetRepositoryImpl({required this.firestore});

  @override
  Future<Either<MediaFailure, Unit>> create(Asset asset) async {
    return right(unit);
  }

  @override
  Future<Either<MediaFailure, Unit>> update(Asset asset) async {
    return right(unit);
  }

  @override
  Future<Either<MediaFailure, Unit>> delete(UniqueID id) async {
    return right(unit);
  }

  @override
  Stream<Either<MediaFailure, List<Asset>>> watchAlbum(albumId) async* {
    final userDoc = await firestore.userDocument();

    yield* userDoc
        .collection("albums/$albumId/assets")
        .snapshots()
        .map((snapshot) => right<MediaFailure, List<Asset>>(snapshot.docs.map((doc) => AssetModel.fromFirestore(doc).toEntity()).toList()))
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
