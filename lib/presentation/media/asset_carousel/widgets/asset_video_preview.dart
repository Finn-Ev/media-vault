import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:photo_view/photo_view.dart';

class AssetVideoPreview extends StatefulWidget {
  final Asset asset;
  const AssetVideoPreview({required this.asset, Key? key}) : super(key: key);

  @override
  State<AssetVideoPreview> createState() => _AssetVideoPreviewState();
}

class _AssetVideoPreviewState extends State<AssetVideoPreview> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        PhotoView(imageProvider: CachedNetworkImageProvider(widget.asset.thumbnailUrl)),
        Container(
          constraints: const BoxConstraints.expand(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withOpacity(0.5),
          ),
          child: Center(
            child: GestureDetector(
              onTap: () => AutoRouter.of(context).push(AssetVideoPlayerPageRoute(url: widget.asset.url)),
              child: Icon(size: 100, Icons.play_arrow_rounded),
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
