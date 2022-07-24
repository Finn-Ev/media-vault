import 'package:bloc/bloc.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:meta/meta.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart' as asset_picker;

part 'asset_controller_event.dart';
part 'asset_controller_state.dart';

class AssetControllerBloc extends Bloc<AssetControllerEvent, AssetControllerState> {
  final AssetRepository assetRepository;

  AssetControllerBloc({required this.assetRepository}) : super(AssetControllerInitial()) {
    on<UploadAssets>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assets.length; i++) {
        final failureOrSuccess = await assetRepository.upload(event.assets[i], event.albumId);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoading(currentStep: i + 1, totalSteps: event.assets.length)),
        );
      }

      emit(AssetControllerLoaded());
    });

    on<DeleteAssets>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assetsToDelete.length; i++) {
        final failureOrSuccess = await assetRepository.delete(event.assetsToDelete[i], event.albumId);

        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoaded()),
        );
      }
    });

    on<ExportAssets>((event, emit) async {
      emit(AssetControllerLoading());

      for (int i = 0; i < event.assetsToExport.length; i++) {
        final failureOrSuccess = await assetRepository.export(event.assetsToExport[i]);
        failureOrSuccess.fold(
          (failure) => emit(AssetControllerFailure(failure)),
          (success) => emit(AssetControllerLoading()),
        );
      }

      emit(AssetControllerLoaded());
    });

    on<MoveAssets>((event, emit) async {
      emit(AssetControllerLoading());

      if (event.copy) {
        for (int i = 0; i < event.assetsToMove.length; i++) {
          final failureOrSuccess = await assetRepository.copy(event.assetsToMove[i], event.destinationAlbumId);
          failureOrSuccess.fold(
            (failure) => emit(AssetControllerFailure(failure)),
            (success) => {},
          );
        }
      } else {
        for (int i = 0; i < event.assetsToMove.length; i++) {
          final failureOrSuccess = await assetRepository.move(event.assetsToMove[i], event.sourceAlbumId, event.destinationAlbumId);
          failureOrSuccess.fold(
            (failure) => emit(AssetControllerFailure(failure)),
            (success) {},
          );
        }
      }
      emit(AssetControllerLoaded());
    });
  }
}
