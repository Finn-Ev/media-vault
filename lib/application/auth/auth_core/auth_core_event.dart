part of 'auth_core_bloc.dart';

@immutable
abstract class AuthCoreEvent {}

class SignOutButtonPressed extends AuthCoreEvent {}

class AuthCheckRequested extends AuthCoreEvent {}
