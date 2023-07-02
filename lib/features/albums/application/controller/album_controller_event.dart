part of 'album_controller_bloc.dart';

@immutable
abstract class AlbumControllerEvent {}

class CreateAlbum extends AlbumControllerEvent {
  final String title;

  CreateAlbum({required this.title});
}

class UpdateAlbum extends AlbumControllerEvent {
  final Album album;

  UpdateAlbum({required this.album});
}

class DeleteAlbum extends AlbumControllerEvent {
  final String id;

  DeleteAlbum({required this.id});
}

class DeleteAllAlbums extends AlbumControllerEvent {}
