import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/album_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/album.dart';

abstract class AlbumRepository {
  Stream<Either<AlbumFailure, List<Album>>> watchAll();

  Future<Either<AlbumFailure, Unit>> create(Album album);

  Future<Either<AlbumFailure, Unit>> update(Album album);

  Future<Either<AlbumFailure, Unit>> delete(UniqueID id);
}
