part of 'asset_controller_bloc.dart';

@immutable
abstract class AssetControllerEvent {}

class UploadAssets extends AssetControllerEvent {
  final List<asset_picker.AssetEntity> assets;
  final String albumId;

  UploadAssets({required this.assets, required this.albumId});
}

class DeleteAssets extends AssetControllerEvent {
  final List<Asset> assetsToDelete;
  final String albumId;

  DeleteAssets({required this.assetsToDelete, required this.albumId});
}

class ExportAssets extends AssetControllerEvent {
  final List<Asset> assetsToExport;

  ExportAssets({required this.assetsToExport});
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
