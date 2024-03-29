import 'package:bloc/bloc.dart';
import 'package:media_vault/features/auth/domain/entities/user.dart';
import 'package:media_vault/features/auth/domain/repositories/remote_auth_repository.dart';
import 'package:meta/meta.dart';

part 'remote_auth_core_event.dart';
part 'remote_auth_core_state.dart';

class AuthCoreBloc extends Bloc<AuthCoreEvent, AuthCoreState> {
  final RemoteAuthRepository authRepository;
  AuthCoreBloc({required this.authRepository}) : super(AuthCoreInitial()) {
    on<LogoutRequested>((event, emit) async {
      await authRepository.signOut();
      emit(AuthCoreUnauthenticated());
    });

    on<AuthCheckRequested>((event, emit) {
      final userOption = authRepository.getSignedInUser();
      userOption.fold(
        () => emit(AuthCoreUnauthenticated()), // userOption is "none()" => no user signed in
        (user) => emit(AuthCoreAuthenticated(user: user)),
      );
    });
  }
}
