import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'asset_carousel_event.dart';
part 'asset_carousel_state.dart';

class AssetCarouselBloc extends Bloc<AssetCarouselEvent, AssetCarouselState> {
  AssetCarouselBloc() : super(AssetCarouselState(showMenuUI: true, carouselIndex: 0, carouselItemCount: 0)) {
    on<ToggleUI>((event, emit) {
      emit(state.copyWith(showMenuUI: !state.showMenuUI));
    });

    on<CarouselIndexChanged>((event, emit) {
      if (event.newIndex == -1) {
        emit(state.copyWith(carouselIndex: state.carouselIndex - 1));
        return;
      }
      emit(state.copyWith(carouselIndex: event.newIndex));
    });

    on<CarouselItemCountChanged>((event, emit) {
      emit(state.copyWith(carouselItemCount: event.newCount));
    });

    on<InitCarouselIndex>((event, emit) {
      emit(state.copyWith(carouselIndex: event.initialCarouselIndex, carouselItemCount: event.carouselItemCount));
    });
  }
}
