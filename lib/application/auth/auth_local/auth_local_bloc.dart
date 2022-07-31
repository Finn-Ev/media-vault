import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_local_event.dart';
part 'auth_local_state.dart';

class AuthLocalBloc extends Bloc<AuthLocalEvent, AuthLocalState> {
  AuthLocalBloc() : super(AuthLocalInitial()) {
    on<AuthLocalEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
