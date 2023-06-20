part of 'remote_auth_form_bloc.dart';

@immutable
abstract class AuthFormEvent {}

class RegisterWithEmailAndPasswordPressed extends AuthFormEvent {
  final String? email;
  final String? password;
  RegisterWithEmailAndPasswordPressed({required this.email, required this.password});
}

class SignInWithEmailAndPasswordPressed extends AuthFormEvent {
  final String? email;
  final String? password;
  SignInWithEmailAndPasswordPressed({required this.email, required this.password});
}

class ForgotPasswordPressed extends AuthFormEvent {
  final String? email;
  ForgotPasswordPressed({required this.email});
}

class SignInWithGooglePressed extends AuthFormEvent {}

class SignInWithApplePressed extends AuthFormEvent {}
