import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/_widgets/loading_overlay.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_carousel_image_view.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_video_preview.dart';

class AssetCarousel extends StatefulWidget {
  final String albumId;
  final String initialAssetId;

  const AssetCarousel({required this.albumId, required this.initialAssetId, Key? key}) : super(key: key);

  @override
  State<AssetCarousel> createState() => _AssetCarouselState();
}

class _AssetCarouselState extends State<AssetCarousel> {
  // by setting the viewport fraction to a low value, all the assets appear on the
  // screen at once for a short amount of time, thus the cached-images get loaded.
  // When combining this with the keepAliveMixin of each carousel image, all the cached-images
  // will stay loaded and don't fade in every time the user through the carousel
  double viewportFraction = 0.01;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        viewportFraction = 1;
      });
    });
  }

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
          final Asset? initialAsset = state.assets.firstWhereOrNull((asset) => asset.id == widget.initialAssetId);

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
                carouselController.jumpToPage(initialIndex)
              },
            );
          } else {
            initialIndex = 0;
          }

          return Stack(
            children: [
              CarouselSlider(
                carouselController: carouselController,
                items: state.assets.map((asset) {
                  if (asset.isVideo) {
                    return AssetVideoPreview(
                      asset: asset,
                    );
                  } else {
                    return AssetCarouselImageView(asset);
                  }
                }).toList(),
                options: CarouselOptions(
                  initialPage: initialIndex,
                  height: MediaQuery.of(context).size.height,
                  onPageChanged: (index, __) {
                    assetCarouselBloc.add(CarouselIndexChanged(newIndex: index));
                  },
                  // viewportFraction: 1,
                  viewportFraction: viewportFraction,
                ),
              ),
              if (viewportFraction != 1) const LoadingOverlay(),
            ],
          );
        } else {
          return const Center(child: LoadingIndicator());
        }
      },
    );
  }
}
