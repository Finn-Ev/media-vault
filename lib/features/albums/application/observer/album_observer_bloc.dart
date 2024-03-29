import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/core/failures/media_failures.dart';
import 'package:media_vault/features/albums/domain/repositories/album_repository.dart';
import 'package:meta/meta.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';

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
        _albumSubscription = albumRepository
            .watchAll()
            .listen((failureOrAlbums) => add(AlbumsUpdated(failureOrAlbums: failureOrAlbums)));
      },
    );

    on<AlbumsUpdated>(
      (event, emit) async {
        event.failureOrAlbums.fold((failure) => emit(AlbumObserverFailure(failure)), (albums) {
          albums.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          var filteredAlbums = albums.where((album) => album.id != trashAlbumId);

          filteredAlbums = filteredAlbums.where((element) => element.deleted == false);

          emit(AlbumObserverLoaded(albums: filteredAlbums.toList()));
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
