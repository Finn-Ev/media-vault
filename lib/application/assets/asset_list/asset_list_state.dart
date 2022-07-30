part of 'asset_list_bloc.dart';

class AssetListState {
  final bool isSelectModeEnabled;
  final List<Asset> selectedAssets;

  const AssetListState({
    this.isSelectModeEnabled = false,
    this.selectedAssets = const [],
  });

  AssetListState copyWith({
    bool? isSelectModeEnabled,
    List<Asset>? selectedAssets,
  }) {
    return AssetListState(
      isSelectModeEnabled: isSelectModeEnabled ?? this.isSelectModeEnabled,
      selectedAssets: selectedAssets ?? this.selectedAssets,
    );
  }
}
