part of 'asset_list_bloc.dart';

@immutable
abstract class AssetListEvent {}

class EnableSelectMode extends AssetListEvent {
  final Asset? initialSelectedAsset;

  EnableSelectMode({this.initialSelectedAsset});
}

class DisableSelectMode extends AssetListEvent {}

class ToggleAsset extends AssetListEvent {
  final Asset asset;

  ToggleAsset({required this.asset});
}

class ToggleSortDirection extends AssetListEvent {}

class AddAllAssets extends AssetListEvent {
  final List<Asset> assets;

  AddAllAssets({required this.assets});
}

class StartedLoadingCachedImages extends AssetListEvent {}

class ResetAssetList extends AssetListEvent {}
