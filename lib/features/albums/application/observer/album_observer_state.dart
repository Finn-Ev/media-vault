part of 'album_observer_bloc.dart';

@immutable
abstract class AlbumObserverState {}

class AlbumObserverInitial extends AlbumObserverState {}

class AlbumObserverLoading extends AlbumObserverState {}

class AlbumObserverLoaded extends AlbumObserverState {
  final List<Album> albums;

  AlbumObserverLoaded({required this.albums});
}

class AlbumObserverFailure extends AlbumObserverState {
  final MediaFailure failure;

  AlbumObserverFailure(this.failure);
}
