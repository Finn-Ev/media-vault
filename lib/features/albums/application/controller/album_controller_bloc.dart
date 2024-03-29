import 'package:bloc/bloc.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/features/albums/domain/repositories/album_repository.dart';
import 'package:meta/meta.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';

part 'album_controller_event.dart';
part 'album_controller_state.dart';

class AlbumControllerBloc extends Bloc<AlbumControllerEvent, AlbumControllerState> {
  final AlbumRepository albumRepository;

  AlbumControllerBloc({required this.albumRepository}) : super(AlbumControllerInitial()) {
    on<CreateAlbum>((event, emit) async {
      emit(AlbumControllerLoading());
      final failureOrSuccess = await albumRepository.create(event.title);

      failureOrSuccess.fold(
        (failure) => emit(AlbumControllerFailure(failure)),
        (success) => emit(AlbumControllerLoaded()),
      );
    });

    on<UpdateAlbum>((event, emit) async {
      emit(AlbumControllerLoading());
      final failureOrSuccess = await albumRepository.update(event.album);

      failureOrSuccess.fold(
        (failure) => emit(AlbumControllerFailure(failure)),
        (success) => emit(AlbumControllerLoaded()),
      );
    });

    on<DeleteAlbum>((event, emit) async {
      emit(AlbumControllerLoading());
      final failureOrSuccess = await albumRepository.moveToTrash(event.id);

      failureOrSuccess.fold(
        (failure) => emit(AlbumControllerFailure(failure)),
        (success) => emit(AlbumControllerLoaded()),
      );
    });

    on<DeleteAllAlbums>((event, emit) async {
      emit(AlbumControllerLoading());
      final failureOrSuccess = await albumRepository.deleteAllPermanently();

      failureOrSuccess.fold(
        (failure) => emit(AlbumControllerFailure(failure)),
        (success) => emit(AlbumControllerLoaded()),
      );
    });
  }
}
