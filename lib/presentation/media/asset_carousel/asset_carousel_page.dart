import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_carousel.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_carousel_bottom_menu.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_carousel_top_menu.dart';

import '../../../injection.dart';

class AssetCarouselPage extends StatelessWidget {
  final String albumId;
  final String initialAssetId;

  const AssetCarouselPage({required this.albumId, required this.initialAssetId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: albumId));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AssetObserverBloc>(create: (context) => assetObserverBloc),
        BlocProvider<AssetControllerBloc>(create: (context) => sl<AssetControllerBloc>()),
        BlocProvider<AssetCarouselBloc>(create: (context) => sl<AssetCarouselBloc>())
      ],
      child: BlocConsumer<AssetObserverBloc, AssetObserverState>(
        listener: (context, state) {
          if (state is AssetObserverLoaded) {
            if (state.assets.isEmpty) {
              AutoRouter.of(context).pop();
            }
          }
        },
        builder: (context, assetObserverState) {
          if (assetObserverState is AssetObserverInitial || assetObserverState is AssetObserverLoading) {
            return const LoadingIndicator();
          }
          if (assetObserverState is AssetObserverLoaded) {
            if (assetObserverState.assets.isEmpty) {
              print('AssetCarouselPage: assets is empty');
              return const Scaffold();
            } else {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  BlocProvider.of<AssetCarouselBloc>(context).add(ToggleUI());
                },
                child: Scaffold(
                  body: BlocBuilder<AssetCarouselBloc, AssetCarouselState>(
                    builder: (context, state) {
                      if (assetObserverState.assets.isEmpty) {
                        return Container();
                      }
                      // if the carousel-index exceeds the number of assets (e.g. when an asset has been moved or deleted),
                      // it will be set to last element of the array.
                      final Asset currentAsset = state.carouselIndex >= assetObserverState.assets.length
                          ? assetObserverState.assets[assetObserverState.assets.length - 1]
                          : assetObserverState.assets[state.carouselIndex];

                      final bool isLastAsset = state.carouselIndex == assetObserverState.assets.length - 1;
                      return SafeArea(
                        child: Stack(
                          children: [
                            AssetCarousel(
                              albumId: albumId,
                              initialAssetId: initialAssetId,
                            ),
                            state.showMenuUI ? const AssetCarouselTopMenu() : Container(),
                            state.showMenuUI ? AssetCarouselBottomMenu(albumId: albumId, currentAsset: currentAsset, lastAlbumAssetIsViewedInCarousel: isLastAsset) : Container(),
                          ],
                        ),
                      );
                    },
                  ),
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
