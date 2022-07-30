import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:meta/meta.dart';

part 'asset_list_event.dart';
part 'asset_list_state.dart';

class AssetListBloc extends Bloc<AssetListEvent, AssetListState> {
  AssetListBloc() : super(const AssetListState()) {
    on<EnableSelectMode>((event, emit) {
      emit(state.copyWith(
        isSelectModeEnabled: true,
        selectedAssets: event.initialSelectedAsset != null ? [event.initialSelectedAsset!] : [],
      ));
    });

    on<DisableSelectMode>((event, emit) {
      emit(state.copyWith(isSelectModeEnabled: false, selectedAssets: []));
    });

    on<ToggleAsset>((event, emit) {
      if (state.selectedAssets.contains(event.asset)) {
        emit(state.copyWith(selectedAssets: state.selectedAssets.where((asset) => asset != event.asset).toList()));
      } else {
        emit(state.copyWith(selectedAssets: state.selectedAssets + [event.asset]));
      }
    });

    on<ToggleSortDirection>((event, emit) {
      emit(state.copyWith(sortByOldestFirst: !state.sortByOldestFirst));
    });

    on<AddAllAssets>((event, emit) {
      emit(state.copyWith(selectedAssets: event.assets));
    });

    on<StartedLoadingCachedImages>((event, emit) async {
      if (!state.cachedImagesHaveBeenLoaded) {
        print('Loading cached images...');
        await Future.delayed(const Duration(milliseconds: 1000), () {
          emit(state.copyWith(cachedImagesHaveBeenLoaded: true));
        });
      }
    });

    on<ResetAssetList>((event, emit) {
      emit(const AssetListState());
    });
  }
}
