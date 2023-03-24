import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:media_vault/infrastructure/repositories/asset_repository_impl.dart';
import 'package:meta/meta.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as asset_picker;

part 'asset_controller_event.dart';
part 'asset_controller_state.dart';

class AssetControllerBloc extends Bloc<AssetControllerEvent, AssetControllerState> {
  final AssetRepository assetRepository;

  AssetControllerBloc({required this.assetRepository}) : super(AssetControllerInitial()) {
    on<UploadAssets>((event, emit) async {
      final assets = event.assets;
      print(assets.length);
      emit(AssetControllerLoading());

      var uploadedAssetIds = [];

      for (int i = 0; i < assets.length; i++) {
        final failureOrSuccess = await assetRepository.upload(assets[i], event.albumId);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerLoading(message: 'Error Uploading asset: ${i + 1}/${assets.length}')),
          (success) {
            uploadedAssetIds.add(assets[i].id);
            emit(AssetControllerLoading(message: 'Uploading assets: ${i + 1}/${assets.length}'));
          },
        );
      }

      emit(AssetControllerLoaded(action: AssetControllerLoadedActions.upload, payload: uploadedAssetIds));
    });

    on<DeleteAssetsPermanently>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assetsToDelete.length; i++) {
        final failureOrSuccess = await assetRepository.deletePermanently(event.assetsToDelete[i]);

        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoading()),
        );
      }

      emit(AssetControllerLoaded(action: AssetControllerLoadedActions.delete));
    });

    on<ExportAssets>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assetsToExport.length; i++) {
        final failureOrSuccess = await assetRepository.export(event.assetsToExport[i]);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) {},
        );
      }

      emit(AssetControllerLoaded(action: AssetControllerLoadedActions.export));
    });

    on<MoveAssets>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assetsToMove.length; i++) {
        final failureOrSuccess =
            await assetRepository.move(event.assetsToMove[i], event.sourceAlbumId, event.destinationAlbumId);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoading()),
        );
      }

      emit(AssetControllerLoaded(action: AssetControllerLoadedActions.move));
    });

    on<MoveAssetsToTrash>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assetsToMove.length; i++) {
        final failureOrSuccess = await assetRepository.moveToTrash(event.assetsToMove[i], event.sourceAlbumId);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoading()),
        );
      }

      emit(AssetControllerLoaded(action: AssetControllerLoadedActions.move));
    });

    on<RemoveAssetsFromTrash>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assets.length; i++) {
        final failureOrSuccess = await assetRepository.move(event.assets[i], trashAlbumId, event.assets[i].albumId);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoading()),
        );
      }

      emit(AssetControllerLoaded(action: AssetControllerLoadedActions.move));
    });

    on<CopyAssets>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assetsToCopy.length; i++) {
        final failureOrSuccess = await assetRepository.copy(event.assetsToCopy[i], event.destinationAlbumId);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoading(
            message: 'Copying assets: ${i + 1}/${event.assetsToCopy.length}',
          )),
        );
      }

      emit(AssetControllerLoaded(action: AssetControllerLoadedActions.copy));
    });

    on<ResetAssetController>((event, emit) => emit(AssetControllerInitial()));
  }
}
