part of 'asset_observer_bloc.dart';

@immutable
abstract class AssetObserverState {}

class AssetObserverInitial extends AssetObserverState {}

class AssetObserverLoading extends AssetObserverState {}

class AssetObserverLoaded extends AssetObserverState {
  final List<Asset> assets;

  AssetObserverLoaded({required this.assets});
}

class AssetObserverFailure extends AssetObserverState {
  final MediaFailure failure;

  AssetObserverFailure(this.failure);
}
