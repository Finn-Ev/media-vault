part of 'asset_controller_bloc.dart';

@immutable
abstract class AssetControllerEvent {}

class UploadAssets extends AssetControllerEvent {
  final List<asset_picker.AssetEntity> assets;
  final String albumId;

  UploadAssets({required this.assets, required this.albumId});
}

class DeleteAssetsPermanently extends AssetControllerEvent {
  final List<Asset> assetsToDelete;

  DeleteAssetsPermanently({required this.assetsToDelete});
}

class MoveAssetsToTrash extends AssetControllerEvent {
  final List<Asset> assetsToMove;
  final String sourceAlbumId;

  MoveAssetsToTrash({
    required this.assetsToMove,
    required this.sourceAlbumId,
  });
}

class RemoveAssetsFromTrash extends AssetControllerEvent {
  final List<Asset> assets;

  RemoveAssetsFromTrash({
    required this.assets,
  });
}

class MoveAssets extends AssetControllerEvent {
  final List<Asset> assetsToMove;
  final String sourceAlbumId;
  final String destinationAlbumId;

  MoveAssets({
    required this.assetsToMove,
    required this.sourceAlbumId,
    required this.destinationAlbumId,
  });
}

class CopyAssets extends AssetControllerEvent {
  final List<Asset> assetsToCopy;
  final String destinationAlbumId;

  CopyAssets({required this.assetsToCopy, required this.destinationAlbumId});
}

class ExportAssets extends AssetControllerEvent {
  final List<Asset> assetsToExport;

  final bool skipActionCallback;

  ExportAssets({required this.assetsToExport, this.skipActionCallback = false});
}

class ResetAssetController extends AssetControllerEvent {}
