import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:photo_view/photo_view.dart';

class AssetCarouselImageView extends StatefulWidget {
  final Asset asset;
  const AssetCarouselImageView(this.asset, {Key? key}) : super(key: key);

  @override
  State<AssetCarouselImageView> createState() => _AssetCarouselImageViewState();
}

class _AssetCarouselImageViewState extends State<AssetCarouselImageView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      behavior: HitTestBehavior.deferToChild,
      onTap: () {
        BlocProvider.of<AssetCarouselBloc>(context).add(ToggleUI());
      },
      child: CachedNetworkImage(
        imageUrl: widget.asset.url,
        imageBuilder: (context, imageProvider) => PhotoView(
          gestureDetectorBehavior: HitTestBehavior.opaque,
          imageProvider: imageProvider,
        ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
