import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_video_preview.dart';
import 'package:photo_view/photo_view.dart';

class AssetCarousel extends StatelessWidget {
  final String albumId;
  final String initialAssetId;

  const AssetCarousel({required this.albumId, required this.initialAssetId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetCarouselBloc = BlocProvider.of<AssetCarouselBloc>(context);

    final carouselController = CarouselController();
    int initialIndex;

    return BlocConsumer<AssetObserverBloc, AssetObserverState>(
      listenWhen: (previous, current) {
        // detect it when an asset of the album is deleted while the carousel is open
        if (previous is AssetObserverLoaded && current is AssetObserverLoaded) {
          return previous.assets.length != current.assets.length;
        }
        return false;
      },
      listener: (context, state) {
        if (state is AssetObserverLoaded) {
          // update the carouselItemCount, when an asset of the album is deleted while the carousel is open
          assetCarouselBloc.add(CarouselItemCountChanged(newCount: state.assets.length));
        }
      },
      builder: (context, state) {
        if (state is AssetObserverLoaded) {
          // firstWhereOrNull is necessary, because the initial asset might not be in the list of assets anymore
          // e.g. when the user deletes the initial asset while the carousel is open
          final Asset? initialAsset = state.assets.firstWhereOrNull((asset) => asset.id == initialAssetId);

          if (initialAsset != null) {
            initialIndex = state.assets.indexOf(initialAsset);

            carouselController.onReady.then(
              (_) => {
                assetCarouselBloc.add(
                  InitCarouselIndex(
                    initialCarouselIndex: initialIndex,
                    carouselItemCount: state.assets.length,
                  ),
                ),
                carouselController.jumpToPage(initialIndex),
              },
            );
          } else {
            initialIndex = 0;
          }

          return CarouselSlider(
            carouselController: carouselController,
            items: state.assets.map((asset) {
              if (asset.isVideo) {
                return AssetVideoPreview(
                  asset: asset,
                );
              }
              return CachedNetworkImage(
                imageUrl: asset.url,

                imageBuilder: (context, imageProvider) => PhotoView(
                  gestureDetectorBehavior: HitTestBehavior.opaque,
                  // minScale: 0.2,
                  imageProvider: imageProvider,
                ),
                // placeholder: (context, url) => const LoadingIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            }).toList(),
            options: CarouselOptions(
              initialPage: initialIndex,
              height: MediaQuery.of(context).size.height,

              onPageChanged: (index, __) {
                assetCarouselBloc.add(CarouselIndexChanged(newIndex: index));
              },
              viewportFraction: 1.0, // to make the carousel full-width
            ),
          );
        } else {
          return const Center(child: LoadingIndicator());
        }
      },
    );
  }
}
