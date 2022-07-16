part of 'album_observer_bloc.dart';

@immutable
abstract class AlbumObserverEvent {}

class AlbumsObserveAll extends AlbumObserverEvent {}

class AlbumsUpdated extends AlbumObserverEvent {
  final Either<AlbumFailure, List<Album>> failureOrAlbums;

  AlbumsUpdated({required this.failureOrAlbums});
}

class AlbumObserverFailureEvent extends AlbumObserverEvent {
  final AlbumFailure failure;

  AlbumObserverFailureEvent(this.failure);
}
