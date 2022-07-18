import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/domain/repositories/asset_repository.dart';
import 'package:meta/meta.dart';

part 'asset_controller_event.dart';
part 'asset_controller_state.dart';

class AssetControllerBloc extends Bloc<AssetControllerEvent, AssetControllerState> {
  final AssetRepository albumRepository;

  AssetControllerBloc({required this.albumRepository}) : super(AssetControllerInitial()) {
    on<UploadImages>((event, emit) async {
      emit(AssetControllerLoading());
      final failureOrSuccess = await albumRepository.uploadImages(event.images, event.albumId);

      failureOrSuccess.fold(
        (failure) => emit(AssetControllerFailure(failure)),
        (success) => emit(AssetControllerLoaded()),
      );
    });

    on<UploadVideo>((event, emit) async {
      emit(AssetControllerLoading());
      final failureOrSuccess = await albumRepository.uploadVideo(event.video, event.albumId);

      failureOrSuccess.fold(
        (failure) => emit(AssetControllerFailure(failure)),
        (success) => emit(AssetControllerLoaded()),
      );
    });

    on<DeleteAsset>((event, emit) async {
      emit(AssetControllerLoading());
      final failureOrSuccess = await albumRepository.delete(event.assetToDelete, event.albumId);

      failureOrSuccess.fold(
        (failure) => emit(AssetControllerFailure(failure)),
        (success) => emit(AssetControllerLoaded()),
      );
    });
  }
}
