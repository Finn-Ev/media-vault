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

class DeleteAsset extends AssetControllerEvent {
  final Asset assetToDelete;
  final UniqueID albumId;

  DeleteAsset({required this.assetToDelete, required this.albumId});
}
