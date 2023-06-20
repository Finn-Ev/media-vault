part of 'asset_controller_bloc.dart';

@immutable
abstract class AssetControllerState {}

class AssetControllerInitial extends AssetControllerState {}

class AssetControllerLoading extends AssetControllerState {
  final String message;

  AssetControllerLoading({this.message = ''});
}

class AssetControllerLoaded extends AssetControllerState {
  final AssetControllerLoadedActions action;
  final dynamic payload;

  AssetControllerLoaded({this.action = AssetControllerLoadedActions.none, this.payload});
}

class AssetControllerFailure extends AssetControllerState {
  final MediaFailure failure;

  AssetControllerFailure(this.failure);
}

enum AssetControllerLoadedActions { upload, delete, export, move, copy, none }
