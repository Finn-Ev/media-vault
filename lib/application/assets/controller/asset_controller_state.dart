part of 'asset_controller_bloc.dart';

@immutable
abstract class AssetControllerState {}

class AssetControllerInitial extends AssetControllerState {}

class AssetControllerLoading extends AssetControllerState {
  final String message;
  AssetControllerLoading({this.message = ''});
}

class AssetControllerLoaded extends AssetControllerState {}

class AssetControllerFailure extends AssetControllerState {
  final MediaFailure failure;

  AssetControllerFailure(this.failure);
}
