import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';

abstract class AssetRepository {
  Future<Either<MediaFailure, Unit>> uploadImage(XFile image, UniqueID albumId);

  Future<Either<MediaFailure, Unit>> uploadVideo(XFile video, UniqueID albumId);

  Future<Either<MediaFailure, Unit>> delete(Asset assetToDelete, UniqueID albumId);

  Stream<Either<MediaFailure, List<Asset>>> watchAlbum(albumId);
}
