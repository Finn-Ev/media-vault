part of 'asset_observer_bloc.dart';

@immutable
abstract class AssetObserverEvent {}

class ObserveAlbumAssets extends AssetObserverEvent {
  final String albumId;
  ObserveAlbumAssets({required this.albumId});
}

class CancelObserveAlbumAssets extends AssetObserverEvent {}

class AssetsUpdated extends AssetObserverEvent {
  final Either<MediaFailure, List<Asset>> failureOrAssets;

  AssetsUpdated({required this.failureOrAssets});
}

class AssetObserverFailureEvent extends AssetObserverEvent {
  final MediaFailure failure;

  AssetObserverFailureEvent(this.failure);
}
