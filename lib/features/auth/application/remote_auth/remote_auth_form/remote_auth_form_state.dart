part of 'remote_auth_form_bloc.dart';

class AuthFormState {
  final bool isSubmitting;
  final bool showValidationMessages;
  final Option<Either<RemoteAuthFailure, Unit>> authFailureOrSuccessOption;

  AuthFormState({
    required this.isSubmitting,
    required this.showValidationMessages,
    required this.authFailureOrSuccessOption,
  });

  AuthFormState copyWith({
    bool? isSubmitting,
    bool? showValidationMessages,
    Option<Either<RemoteAuthFailure, Unit>>? authFailureOrSuccessOption,
  }) {
    return AuthFormState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      showValidationMessages: showValidationMessages ?? this.showValidationMessages,
      authFailureOrSuccessOption: authFailureOrSuccessOption ?? this.authFailureOrSuccessOption,
    );
  }
}
