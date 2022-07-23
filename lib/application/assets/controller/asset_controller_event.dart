part of 'asset_controller_bloc.dart';

@immutable
abstract class AssetControllerEvent {}

class UploadAssets extends AssetControllerEvent {
  final List<asset_picker.AssetEntity> assets;
  final UniqueID albumId;

  UploadAssets({required this.assets, required this.albumId});
}

class DeleteAssets extends AssetControllerEvent {
  final List<Asset> assetsToDelete;
  final UniqueID albumId;

  DeleteAssets({required this.assetsToDelete, required this.albumId});
}

class ExportAssets extends AssetControllerEvent {
  final List<Asset> assetsToExport;

  ExportAssets({required this.assetsToExport});
}
