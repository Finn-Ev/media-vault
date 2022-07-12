import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_core_event.dart';
part 'auth_core_state.dart';

class AuthCoreBloc extends Bloc<AuthCoreEvent, AuthCoreState> {
  AuthCoreBloc() : super(AuthCoreInitial()) {
    on<SignOutButtonPressed>((event, emit) {
      // TODO: implement event handler
    });

    on<AuthCheckRequested>((event, emit) {
      // TODO: implement event handler
    });
  }
}
