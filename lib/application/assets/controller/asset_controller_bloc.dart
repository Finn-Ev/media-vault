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
      //? a clone is needed because [event.assets] gets somehow modified while iterating
      //* I guess that the wechat_assets_picker package in version 8.4 is modifying the list subsequently (everything was working fine in 7.3)
      final assets = [...event.assets];
      emit(AssetControllerLoading(message: 'Uploading asset${assets.length > 1 ? ": 1/${assets.length}" : ""}...'));

      var uploadedAssetIds = [];

      for (int i = 0; i < assets.length; i++) {
        var asset = assets[i];
        final failureOrSuccess = await assetRepository.upload(asset, event.albumId);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerLoading(message: 'Error Uploading asset: ${i + 1}/${assets.length}')),
          (success) {
            uploadedAssetIds.add(asset.id);
            // asset with index i+1 has just been uploaded, so the asset that gets currently uploaded is i+2
            emit(AssetControllerLoading(message: 'Uploading asset: ${i + 2}/${assets.length}...'));
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
