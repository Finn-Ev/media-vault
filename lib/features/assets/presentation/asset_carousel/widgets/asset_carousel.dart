import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/assets/application/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/features/assets/domain/entities/asset.dart';
import 'package:media_vault/features/assets/presentation/asset_carousel/widgets/asset_carousel_image_view.dart';
import 'package:media_vault/features/assets/presentation/asset_carousel/widgets/asset_video_preview.dart';
import 'package:media_vault/shared/widgets/loading_overlay.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AssetCarousel extends StatefulWidget {
  final String albumId;
  final List<Asset> assets;
  final int initialIndex;

  const AssetCarousel({required this.albumId, required this.initialIndex, required this.assets, Key? key})
      : super(key: key);

  @override
  State<AssetCarousel> createState() => _AssetCarouselState();
}

class _AssetCarouselState extends State<AssetCarousel> {
  late PageController carouselController;
  bool loadingOverlayVisible = true;

  @override
  void initState() {
    BlocProvider.of<AssetCarouselBloc>(context).add(ToggleUI());
    BlocProvider.of<AssetCarouselBloc>(context).add(InitCarouselIndex(
        initialCarouselIndex: widget.initialIndex, carouselItemCount: widget.assets.length));
    carouselController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 1,
    );

    super.initState();

    // display each asset for a short moment, so that the images get pre-cached / pre-loaded.
    // When combining this with the keepAliveMixin of each carousel image, all the cached-images
    // will stay loaded and don't fade in when the user navigates through the carousel
    int i = 0;
    Timer.periodic(const Duration(milliseconds: 50), (timer) {
      carouselController.jumpToPage(i);

      if (i == widget.assets.length) {
        timer.cancel();
        carouselController.jumpToPage(widget.initialIndex);
        setState(() {
          loadingOverlayVisible = false;
        });
        BlocProvider.of<AssetCarouselBloc>(context).add(ToggleUI());
      }
      i++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final assetCarouselBloc = BlocProvider.of<AssetCarouselBloc>(context);

    return Stack(
      children: [
        PhotoViewGallery.builder(
          itemCount: widget.assets.length,
          builder: (context, index) {
            final asset = widget.assets[index];
            return PhotoViewGalleryPageOptions.customChild(
              // gestureDetectorBehavior: HitTestBehavior.opaque,
              child: asset.isVideo ? AssetVideoPreview(asset: asset) : AssetCarouselImageView(asset),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained * 0.8,
              maxScale: PhotoViewComputedScale.contained * 4,
              heroAttributes: PhotoViewHeroAttributes(tag: asset.id),
            );
          },
          onPageChanged: (index) {
            assetCarouselBloc.add(CarouselIndexChanged(newIndex: index));
          },
          // wantKeepAlive: true,
          loadingBuilder: (context, event) => Container(),
          pageController: carouselController,
        ),
        if (loadingOverlayVisible) const LoadingOverlay(),
      ],
    );
  }
}
