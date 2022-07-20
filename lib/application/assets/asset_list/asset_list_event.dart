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