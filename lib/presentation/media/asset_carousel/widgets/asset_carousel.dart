import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_video_preview.dart';
import 'package:photo_view/photo_view.dart';

class AssetCarousel extends StatelessWidget {
  final String albumId;
  final String initialAssetId;

  const AssetCarousel({required this.albumId, required this.initialAssetId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetObserverBloc, AssetObserverState>(
      builder: (context, state) {
        if (state is AssetObserverLoaded) {
          return CarouselSlider(
            items: state.assets.map((asset) {
              if (asset.isVideo) {
                return AssetVideoPreview(url: asset.url);
              }
              return CachedNetworkImage(
                imageUrl: asset.url,
                imageBuilder: (context, imageProvider) => PhotoView(
                  gestureDetectorBehavior: HitTestBehavior.translucent,
                  minScale: 0.2,
                  imageProvider: imageProvider,
                ),
                placeholder: (context, url) => const LoadingIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            }).toList(),
            options: CarouselOptions(
              initialPage: state.assets.indexOf(state.assets.firstWhere((asset) => asset.id.value == initialAssetId)),
              height: MediaQuery.of(context).size.height,
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
