import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/domain/repositories/album_repository.dart';
import 'package:media_vault/infrastructure/repositories/asset_repository_impl.dart';
import 'package:meta/meta.dart';

part 'album_observer_event.dart';
part 'album_observer_state.dart';

class AlbumObserverBloc extends Bloc<AlbumObserverEvent, AlbumObserverState> {
  final AlbumRepository albumRepository;

  StreamSubscription<Either<MediaFailure, List<Album>>>? _albumSubscription;

  AlbumObserverBloc({required this.albumRepository}) : super(AlbumObserverInitial()) {
    on<AlbumsObserveAll>(
      (event, emit) async {
        emit(AlbumObserverLoading());
        await _albumSubscription?.cancel();
        _albumSubscription =
            albumRepository.watchAll().listen((failureOrAlbums) => add(AlbumsUpdated(failureOrAlbums: failureOrAlbums)));
      },
    );

    on<AlbumsUpdated>(
      (event, emit) async {
        event.failureOrAlbums.fold((failure) => emit(AlbumObserverFailure(failure)), (albums) {
          albums.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          emit(AlbumObserverLoaded(albums: albums.where((element) => element.id != trashAlbumId).toList()));
        });
      },
    );
  }

  @override
  Future<void> close() {
    _albumSubscription?.cancel();
    return super.close();
  }
}
