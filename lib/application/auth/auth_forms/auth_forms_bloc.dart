import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_forms_event.dart';
part 'auth_forms_state.dart';

class AuthFormsBloc extends Bloc<AuthFormsEvent, AuthFormsState> {
  AuthFormsBloc() : super(AuthFormsInitial()) {
    on<AuthFormsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
