import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as asset_picker;

abstract class AssetRepository {
  Future<Either<MediaFailure, Unit>> upload(asset_picker.AssetEntity asset, UniqueID albumId);

  Future<Either<MediaFailure, Unit>> delete(Asset assetToDelete, UniqueID albumId);

  Future<Either<MediaFailure, Unit>> move(Asset assetToMove, UniqueID sourceAlbumId, UniqueID destinationAlbumId);

  Future<Either<MediaFailure, Unit>> copy(Asset assetToCopy, UniqueID destinationAlbumId);

  Future<Either<MediaFailure, Unit>> export(Asset assetToExport);

  Stream<Either<MediaFailure, List<Asset>>> watchAlbum(albumId);
}
