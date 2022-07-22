part of 'asset_carousel_bloc.dart';

@immutable
abstract class AssetCarouselEvent {}

class ToggleUI extends AssetCarouselEvent {}

class CarouselIndexChanged extends AssetCarouselEvent {
  final int newIndex;

  CarouselIndexChanged({required this.newIndex}) : super();
}

class InitCarouselIndex extends AssetCarouselEvent {
  final int initialCarouselIndex;
  final int carouselItemCount;

  InitCarouselIndex({required this.initialCarouselIndex, required this.carouselItemCount}) : super();
}
