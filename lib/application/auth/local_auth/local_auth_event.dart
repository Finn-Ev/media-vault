part of 'local_auth_bloc.dart';

@immutable
abstract class AuthLocalEvent {}

class LocalAuthSetupCheckRequest extends AuthLocalEvent {}

class LocalAuthPinWasEntered extends AuthLocalEvent {
  final String pin;
  LocalAuthPinWasEntered({required this.pin});
}

class LocalAuthSetupPinsMatch extends AuthLocalEvent {
  final String pin;
  LocalAuthSetupPinsMatch({required this.pin});
}
