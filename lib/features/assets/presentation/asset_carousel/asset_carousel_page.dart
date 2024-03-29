import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/albums/application/observer/album_observer_bloc.dart';
import 'package:media_vault/features/assets/application/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/features/assets/application/observer/asset_observer_bloc.dart';
import 'package:media_vault/features/assets/domain/entities/asset.dart';
import 'package:media_vault/features/assets/presentation/asset_carousel/widgets/asset_carousel.dart';
import 'package:media_vault/features/assets/presentation/asset_carousel/widgets/asset_carousel_bottom_menu.dart';
import 'package:media_vault/features/assets/presentation/asset_carousel/widgets/asset_carousel_top_menu.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/shared/widgets/loading_indicator.dart';

@RoutePage()
class AssetCarouselPage extends StatelessWidget {
  final String albumId;
  final int initialIndex;

  const AssetCarouselPage({required this.albumId, required this.initialIndex, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: albumId));
    final albumObserverBloc = sl<AlbumObserverBloc>()..add(AlbumsObserveAll());

    return MultiBlocProvider(
      providers: [
        BlocProvider<AssetObserverBloc>(create: (context) => assetObserverBloc),
        BlocProvider<AlbumObserverBloc>(create: (context) => albumObserverBloc),
        BlocProvider<AssetCarouselBloc>(create: (context) => sl<AssetCarouselBloc>()),
      ],
      child: BlocConsumer<AssetObserverBloc, AssetObserverState>(
        listener: (context, state) {
          if (state is AssetObserverLoaded) {
            if (state.assets.isEmpty) {
              AutoRouter.of(context).pop();
            }
            // update the carouselItemCount, when an asset of the album is deleted while the carousel is open
            BlocProvider.of<AssetCarouselBloc>(context).add(CarouselItemCountChanged(newCount: state.assets.length));
          }
        },
        builder: (context, assetObserverState) {
          if (assetObserverState is AssetObserverInitial || assetObserverState is AssetObserverLoading) {
            return const LoadingIndicator();
          }
          if (assetObserverState is AssetObserverLoaded) {
            if (assetObserverState.assets.isEmpty) {
              return const Scaffold();
            } else {
              return Scaffold(
                body: BlocBuilder<AssetCarouselBloc, AssetCarouselState>(
                  builder: (context, state) {
                    if (assetObserverState.assets.isEmpty) {
                      return Container();
                    }
                    // if the carousel-index exceeds the number of assets (e.g. when an asset has been moved or deleted),
                    // it will be set to last element of the array.
                    Asset currentAsset;

                    if (state.carouselIndex != -1) {
                      currentAsset = state.carouselIndex >= assetObserverState.assets.length
                          ? assetObserverState.assets.last
                          : assetObserverState.assets[state.carouselIndex];
                    } else {
                      return Container();
                    }

                    final bool isLastAsset = state.carouselIndex == assetObserverState.assets.length - 1;

                    return SafeArea(
                      child: Stack(
                        children: [
                          AssetCarousel(
                            assets: assetObserverState.assets,
                            albumId: albumId,
                            initialIndex: initialIndex,
                          ),
                          state.showMenuUI ? const AssetCarouselTopMenu() : Container(),
                          state.showMenuUI
                              ? AssetCarouselBottomMenu(
                                  albumId: albumId, currentAsset: currentAsset, lastAlbumAssetIsViewedInCarousel: isLastAsset)
                              : Container(),
                        ],
                      ),
                    );
                  },
                ),
              );
            }
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
