import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/features/assets/domain/entities/asset.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as asset_picker;

abstract class AssetRepository {
  Future<Either<MediaFailure, Unit>> upload(asset_picker.AssetEntity asset, String albumId);

  Future<Either<MediaFailure, Unit>> deletePermanently(Asset assetToDelete);

  Future<Either<MediaFailure, Unit>> moveToTrash(Asset assetToMove, String sourceAlbumId);

  Future<Either<MediaFailure, Unit>> move(Asset assetToMove, String sourceAlbumId, String destinationAlbumId);

  Future<Either<MediaFailure, Unit>> copy(Asset assetToCopy, String destinationAlbumId);

  Future<Either<MediaFailure, Unit>> export(Asset assetToExport);

  Stream<Either<MediaFailure, List<Asset>>> watchAlbum(albumId);
}
