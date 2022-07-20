part of 'asset_controller_bloc.dart';

@immutable
abstract class AssetControllerEvent {}

class UploadImages extends AssetControllerEvent {
  final List<XFile> images;
  final UniqueID albumId;

  UploadImages({required this.images, required this.albumId});
}

class UploadVideo extends AssetControllerEvent {
  final XFile video;
  final UniqueID albumId;

  UploadVideo({required this.video, required this.albumId});
}

class DeleteAssets extends AssetControllerEvent {
  final List<Asset> assetsToDelete;
  final UniqueID albumId;

  DeleteAssets({required this.assetsToDelete, required this.albumId});
}
