part of 'asset_controller_bloc.dart';

@immutable
abstract class AssetControllerState {}

class AssetControllerInitial extends AssetControllerState {}

class AssetControllerLoading extends AssetControllerState {
  final int currentStep;
  final int totalSteps;
  AssetControllerLoading({this.currentStep = -1, this.totalSteps = -1});
}

class AssetControllerLoaded extends AssetControllerState {}

class AssetControllerFailure extends AssetControllerState {
  final MediaFailure failure;

  AssetControllerFailure(this.failure);
}
