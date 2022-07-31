import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_widgets/loading_overlay.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_carousel_image_view.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_video_preview.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class AssetCarousel extends StatefulWidget {
  final String albumId;
  final List<Asset> assets;
  final int initialIndex;

  const AssetCarousel({required this.albumId, required this.initialIndex, required this.assets, Key? key}) : super(key: key);

  @override
  State<AssetCarousel> createState() => _AssetCarouselState();
}

class _AssetCarouselState extends State<AssetCarousel> {
  // by setting the viewport fraction to a low value, all the assets appear on the
  // screen at once for a short amount of time, thus the cached-images get loaded.
  // When combining this with the keepAliveMixin of each carousel image, all the cached-images
  // will stay loaded and don't fade in every time the user through the carousel
  // double viewportFraction = 0.01;
  double viewportFraction = 1;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AssetCarouselBloc>(context).add(InitCarouselIndex(initialCarouselIndex: widget.initialIndex, carouselItemCount: widget.assets.length));
    Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        viewportFraction = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final assetCarouselBloc = BlocProvider.of<AssetCarouselBloc>(context);

    final PageController carouselController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: viewportFraction,
    );

    return Stack(
      children: [
        PhotoViewGallery.builder(
          itemCount: widget.assets.length,
          builder: (context, index) {
            final asset = widget.assets[index];
            return PhotoViewGalleryPageOptions.customChild(
              // gestureDetectorBehavior: HitTestBehavior.deferToChild,
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
          loadingBuilder: (context, event) => Container(),
          wantKeepAlive: true,
          pageController: carouselController,
        ),
        if (viewportFraction != 1) const LoadingOverlay(),
      ],
    );
  }
}
