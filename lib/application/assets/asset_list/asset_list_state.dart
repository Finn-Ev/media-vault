part of 'asset_list_bloc.dart';

class AssetListState {
  final bool isSelectModeEnabled;
  final List<Asset> selectedAssets;
  final bool sortByOldestFirst;
  final bool cachedImagesHaveBeenLoaded;

  const AssetListState({
    this.isSelectModeEnabled = false,
    this.selectedAssets = const [],
    this.sortByOldestFirst = true,
    this.cachedImagesHaveBeenLoaded = false,
  });

  AssetListState copyWith({
    bool? isSelectModeEnabled,
    List<Asset>? selectedAssets,
    bool? sortByOldestFirst,
    bool? cachedImagesHaveBeenLoaded,
  }) {
    return AssetListState(
      isSelectModeEnabled: isSelectModeEnabled ?? this.isSelectModeEnabled,
      selectedAssets: selectedAssets ?? this.selectedAssets,
      sortByOldestFirst: sortByOldestFirst ?? this.sortByOldestFirst,
      cachedImagesHaveBeenLoaded: cachedImagesHaveBeenLoaded ?? this.cachedImagesHaveBeenLoaded,
    );
  }
}
