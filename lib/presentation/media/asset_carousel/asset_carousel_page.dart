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
      child: BlocBuilder<AssetObserverBloc, AssetObserverState>(
        builder: (context, assetObserverState) {
          if (assetObserverState is AssetObserverInitial || assetObserverState is AssetObserverLoading) {
            return const LoadingIndicator();
          }
          if (assetObserverState is AssetObserverLoaded) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                BlocProvider.of<AssetCarouselBloc>(context).add(ToggleUI());
              },
              child: Scaffold(
                body: BlocBuilder<AssetCarouselBloc, AssetCarouselState>(
                  builder: (context, state) {
                    final Asset currentAsset = assetObserverState.assets[state.carouselIndex];
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
          } else {
            return const Center(child: Text('Error'));
          }
        },
      ),
    );
  }
}
