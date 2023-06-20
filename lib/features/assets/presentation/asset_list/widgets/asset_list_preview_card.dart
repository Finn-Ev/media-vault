import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/features/assets/application/asset_list/asset_list_bloc.dart';
import 'package:media_vault/features/assets/domain/entities/asset.dart';
import 'package:media_vault/routes/routes.gr.dart';

class AssetListPreviewCard extends StatefulWidget {
  final Asset asset;
  final int index;
  final String albumId;
  final bool isSelected;

  const AssetListPreviewCard({
    required this.asset,
    required this.index,
    required this.albumId,
    required this.isSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<AssetListPreviewCard> createState() => _AssetListPreviewCardState();
}

class _AssetListPreviewCardState extends State<AssetListPreviewCard> with AutomaticKeepAliveClientMixin {
  String _durationString(int secDuration) {
    final duration = Duration(seconds: secDuration);
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    precacheImage(
      CachedNetworkImageProvider(widget.asset.isVideo ? widget.asset.thumbnailUrl : widget.asset.url),
      context,
    );

    return BlocBuilder<AssetListBloc, AssetListState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (widget.albumId == trashAlbumId) {
              if (!state.isSelectModeEnabled) {
                BlocProvider.of<AssetListBloc>(context)
                    .add(EnableSelectMode(initialSelectedAsset: widget.asset));
              } else {
                BlocProvider.of<AssetListBloc>(context).add(ToggleAsset(asset: widget.asset));
              }
            } else {
              if (state.isSelectModeEnabled) {
                BlocProvider.of<AssetListBloc>(context).add(ToggleAsset(asset: widget.asset));
              } else {
                AutoRouter.of(context)
                    .push(AssetCarouselRoute(albumId: widget.albumId, initialIndex: widget.index));
              }
            }
          },
          onLongPress: () {
            // activate select mode and set this asset as selected
            if (!state.isSelectModeEnabled) {
              BlocProvider.of<AssetListBloc>(context)
                  .add(EnableSelectMode(initialSelectedAsset: widget.asset));
            }
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: CachedNetworkImage(
                  imageUrl: widget.asset.isVideo ? widget.asset.thumbnailUrl : widget.asset.url,
                  fit: BoxFit.cover,
                ),
              ),
              if (widget.asset.isVideo)
                const Positioned(top: 0, left: 0, child: Icon(CupertinoIcons.video_camera_solid)),
              // if (asset.isVideo) Text(asset.duration.toString()),
              if (widget.asset.isVideo)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    _durationString(widget.asset.duration),
                  ),
                ),
              if (widget.isSelected)
                Container(
                  constraints: const BoxConstraints.expand(),
                  color: Colors.black.withOpacity(0.5),
                  child: const Icon(size: 35.0, Icons.check_circle),
                ),
            ],
          ),
        );
      },
    );
  }

  // prevent reloading the cached image each time the widget comes back into view
  @override
  bool get wantKeepAlive => true;
}
