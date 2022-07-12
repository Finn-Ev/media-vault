part of 'auth_core_bloc.dart';

@immutable
abstract class AuthCoreEvent {}

class SignOutButtonPressed extends AuthCoreEvent {}

class AuthStateAuthenticated extends AuthCoreState {}

class AuthCheckRequested extends AuthCoreEvent {}
