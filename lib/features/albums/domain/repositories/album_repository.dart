import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';

abstract class AlbumRepository {
  Future<Either<MediaFailure, Unit>> create(String title);

  Future<Either<MediaFailure, Unit>> update(Album album);

  Future<Either<MediaFailure, Unit>> createTrash();

  // marks the album as deleted (so it won't be visible to the user) and moves the assets to trash
  Future<Either<MediaFailure, Unit>> moveToTrash(String albumId);

  // deletes all albums and assets permanently (data wipe)
  Future<Either<MediaFailure, Unit>> deleteAllPermanently();

  Stream<Either<MediaFailure, List<Album>>> watchAll();
}
