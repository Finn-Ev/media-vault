part of 'asset_list_bloc.dart';

class AssetListState {
  final bool isSelectModeEnabled;
  final List<Asset> selectedAssets;
  final bool sortByOldestFirst;

  const AssetListState({required this.isSelectModeEnabled, required this.selectedAssets, this.sortByOldestFirst = true});

  AssetListState copyWith({bool? isSelectModeEnabled, List<Asset>? selectedAssets, bool? sortByOldestFirst}) {
    return AssetListState(
      isSelectModeEnabled: isSelectModeEnabled ?? this.isSelectModeEnabled,
      selectedAssets: selectedAssets ?? this.selectedAssets,
      sortByOldestFirst: sortByOldestFirst ?? this.sortByOldestFirst,
    );
  }
}
