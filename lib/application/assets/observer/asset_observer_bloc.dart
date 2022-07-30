import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:meta/meta.dart';

part 'asset_observer_event.dart';
part 'asset_observer_state.dart';

class AssetObserverBloc extends Bloc<AssetObserverEvent, AssetObserverState> {
  final AssetRepository assetRepository;

  StreamSubscription<Either<MediaFailure, List<Asset>>>? _assetSubscription;

  AssetObserverBloc({required this.assetRepository}) : super(AssetObserverInitial()) {
    on<ObserveAlbumAssets>(
      (event, emit) async {
        emit(AssetObserverLoading());
        await _assetSubscription?.cancel();
        _assetSubscription = assetRepository.watchAlbum(event.albumId).listen((failureOrAssets) => add(AssetsUpdated(failureOrAssets: failureOrAssets)));
      },
    );

    on<AssetsUpdated>(
      (event, emit) async {
        event.failureOrAssets.fold((failure) {
          emit(AssetObserverFailure(failure));
        }, (assets) {
          assets.sort((a, b) => a.uploadedAt.compareTo(b.uploadedAt));
          emit(AssetObserverLoaded(assets: assets));
        });
      },
    );
  }

  @override
  Future<void> close() {
    _assetSubscription?.cancel();
    return super.close();
  }
}
