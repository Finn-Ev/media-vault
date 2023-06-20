part of 'asset_carousel_bloc.dart';

class AssetCarouselState {
  final bool showMenuUI;
  final int carouselIndex;
  final int carouselItemCount;

  AssetCarouselState({
    required this.showMenuUI,
    required this.carouselIndex,
    required this.carouselItemCount,
  });

  AssetCarouselState copyWith({
    bool? showMenuUI,
    int? carouselIndex,
    int? carouselItemCount,
  }) {
    return AssetCarouselState(
      showMenuUI: showMenuUI ?? this.showMenuUI,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      carouselItemCount: carouselItemCount ?? this.carouselItemCount,
    );
  }
}
