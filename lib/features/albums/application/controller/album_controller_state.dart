part of 'album_controller_bloc.dart';

@immutable
abstract class AlbumControllerState {}

class AlbumControllerInitial extends AlbumControllerState {}

class AlbumControllerLoading extends AlbumControllerState {}

class AlbumControllerLoaded extends AlbumControllerState {}

class AlbumControllerFailure extends AlbumControllerState {
  final MediaFailure failure;

  AlbumControllerFailure(this.failure);
}
