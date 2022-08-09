import 'package:bloc/bloc.dart';
import 'package:media_vault/domain/repositories/local_auth_repository.dart';
import 'package:meta/meta.dart';

part 'local_auth_event.dart';
part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<AuthLocalEvent, LocalAuthState> {
  final LocalAuthRepository localAuthRepository;
  LocalAuthBloc({required this.localAuthRepository}) : super(LocalAuthState.initial()) {
    on<LocalAuthSetupCheckRequest>((event, emit) async {
      final pinOrFailure = await localAuthRepository.getSavedPIN();

      pinOrFailure.fold(
        (failure) => emit(state.copyWith(isSetup: false, isAuthenticated: false)),
        (pin) {
          if (pin != null) {
            emit(state.copyWith(isSetup: true, isAuthenticated: false));
          } else {
            emit(state.copyWith(isSetup: false, isAuthenticated: false));
          }
        },
      );
    });

    on<LocalAuthPinWasEntered>((event, emit) async {
      final pinOrFailure = await localAuthRepository.getSavedPIN();

      pinOrFailure.fold(
        (failure) => emit(state.copyWith(isSetup: false, isAuthenticated: false)),
        (savedPin) {
          if (event.pin == savedPin) {
            emit(state.copyWith(isSetup: true, isAuthenticated: true, incorrectPinFailure: false));
          } else {
            emit(state.copyWith(isSetup: true, isAuthenticated: false, incorrectPinFailure: true));
          }
        },
      );
    });

    on<LocalAuthSetupPinsMatch>((event, emit) async {
      // save the PIN to the device and authenticate the user afterwards
      await localAuthRepository.savePIN(pin: event.pin);
      emit(state.copyWith(isSetup: true, isAuthenticated: true));
    });
  }
}
