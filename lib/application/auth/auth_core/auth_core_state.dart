part of 'auth_core_bloc.dart';

@immutable
abstract class AuthCoreState {}

class AuthCoreInitial extends AuthCoreState {}

class AuthCoreUnauthenticated extends AuthCoreState {}
