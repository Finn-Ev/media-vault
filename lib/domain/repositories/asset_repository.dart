import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';

abstract class AssetRepository {
  Stream<Either<MediaFailure, List<Asset>>> watchAlbum(albumId);

  Future<Either<MediaFailure, Unit>> create(Asset asset);

  Future<Either<MediaFailure, Unit>> update(Asset asset);

  Future<Either<MediaFailure, Unit>> delete(UniqueID id);
}
