import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'album_controller_event.dart';
part 'album_controller_state.dart';

class AlbumControllerBloc extends Bloc<AlbumControllerEvent, AlbumControllerState> {
  AlbumControllerBloc() : super(AlbumControllerInitial()) {
    on<AlbumControllerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
