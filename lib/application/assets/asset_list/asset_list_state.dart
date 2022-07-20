part of 'asset_list_bloc.dart';

class AssetListState {
  final bool isSelectModeEnabled;
  final List<Asset> selectedAssets;

  const AssetListState({required this.isSelectModeEnabled, required this.selectedAssets});

  AssetListState copyWith({bool? isSelectModeEnabled, List<Asset>? selectedAssets}) {
    return AssetListState(
      isSelectModeEnabled: isSelectModeEnabled ?? this.isSelectModeEnabled,
      selectedAssets: selectedAssets ?? this.selectedAssets,
    );
  }
}
