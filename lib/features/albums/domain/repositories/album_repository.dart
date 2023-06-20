import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';

abstract class AlbumRepository {
  Stream<Either<MediaFailure, List<Album>>> watchAll();

  Future<Either<MediaFailure, Unit>> create(String title);

  Future<Either<MediaFailure, Unit>> update(Album album);

  Future<Either<MediaFailure, Unit>> createTrash();

  Future<Either<MediaFailure, Unit>> moveToTrash(String albumId);

  Future<Either<MediaFailure, Unit>> deletePermanently(String albumId);
}
