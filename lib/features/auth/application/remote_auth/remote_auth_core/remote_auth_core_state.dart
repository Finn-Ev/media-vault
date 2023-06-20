part of 'remote_auth_core_bloc.dart';

@immutable
abstract class AuthCoreState {}

class AuthCoreInitial extends AuthCoreState {}

class AuthCoreUnauthenticated extends AuthCoreState {}

class AuthCoreAuthenticated extends AuthCoreState {
  final CustomUser user;

  AuthCoreAuthenticated({required this.user});
}
