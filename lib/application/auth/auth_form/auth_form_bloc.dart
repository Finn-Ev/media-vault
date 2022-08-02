import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:media_vault/core/failures/auth_failures.dart';
import 'package:media_vault/domain/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_form_event.dart';
part 'auth_form_state.dart';

class AuthFormBloc extends Bloc<AuthFormEvent, AuthFormState> {
  final AuthRepository authRepository;

  AuthFormBloc({required this.authRepository})
      : super(AuthFormState(
          isSubmitting: false,
          showValidationMessages: false,
          authFailureOrSuccessOption: none(),
        )) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        final failureOrSuccess = await authRepository.registerWithEmailAndPassword(
          email: event.email!,
          password: event.password!,
        );

        emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });

    on<SignInWithEmailAndPasswordPressed>((event, emit) async {
      if (event.email == null || event.password == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        final failureOrSuccess = await authRepository.signInWithEmailAndPassword(
          email: event.email!,
          password: event.password!,
        );
        emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });

    on<SignInWithGooglePressed>((event, emit) async {
      emit(state.copyWith(isSubmitting: false));
      final failureOrSuccess = await authRepository.signInWithGoogle();

      emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
    });

    on<SignInWithApplePressed>((event, emit) async {
      emit(state.copyWith(isSubmitting: false));
      final failureOrSuccess = await authRepository.signInWithApple();

      emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
    });

    on<ForgotPasswordPressed>((event, emit) async {
      if (event.email == null) {
        emit(state.copyWith(isSubmitting: false, showValidationMessages: true));
      } else {
        emit(state.copyWith(isSubmitting: true, showValidationMessages: false));
        final failureOrSuccess = await authRepository.sendPasswordResetEmail(
          email: event.email!,
        );
        emit(state.copyWith(isSubmitting: false, authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });
  }
}
