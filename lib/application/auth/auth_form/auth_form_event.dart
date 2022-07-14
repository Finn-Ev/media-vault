part of 'auth_form_bloc.dart';

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

class SignInWithGooglePressed extends AuthFormEvent {}

class SignInWithApplePressed extends AuthFormEvent {}
