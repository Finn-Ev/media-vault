part of 'local_auth_bloc.dart';

class LocalAuthState {
  final bool isSetup;
  final bool isAuthenticated;
  final bool incorrectPinFailure;
  LocalAuthState({required this.isSetup, required this.isAuthenticated, required this.incorrectPinFailure});

  factory LocalAuthState.initial() {
    return LocalAuthState(isSetup: false, isAuthenticated: false, incorrectPinFailure: false);
  }

  LocalAuthState copyWith({
    bool? isSetup,
    bool? isAuthenticated,
    bool? incorrectPinFailure,
  }) {
    return LocalAuthState(
      isSetup: isSetup ?? this.isSetup,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      incorrectPinFailure: incorrectPinFailure ?? this.incorrectPinFailure,
    );
  }
}
