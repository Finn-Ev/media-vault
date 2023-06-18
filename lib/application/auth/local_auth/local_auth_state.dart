part of 'local_auth_bloc.dart';

class LocalAuthState {
  final bool hasBeenSetup;
  final bool isAuthenticated;
  final bool incorrectPinFailure;
  LocalAuthState(
      {required this.hasBeenSetup, required this.isAuthenticated, required this.incorrectPinFailure});

  factory LocalAuthState.initial() {
    return LocalAuthState(hasBeenSetup: false, isAuthenticated: false, incorrectPinFailure: false);
  }

  LocalAuthState copyWith({
    bool? isSetup,
    bool? isAuthenticated,
    bool? incorrectPinFailure,
  }) {
    return LocalAuthState(
      hasBeenSetup: isSetup ?? this.hasBeenSetup,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      incorrectPinFailure: incorrectPinFailure ?? this.incorrectPinFailure,
    );
  }
}
