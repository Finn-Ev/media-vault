import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

class AssetPreviewCard extends StatelessWidget {
  final Asset asset;
  final String albumId;
  final bool isSelected;

  const AssetPreviewCard({required this.asset, required this.albumId, required this.isSelected, Key? key}) : super(key: key);

  String _durationString(int secDuration) {
    final duration = Duration(seconds: secDuration);
    String minutes = (duration.inMinutes % 60).toString().padLeft(2, '0');
    String seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetListBloc, AssetListState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (state.isSelectModeEnabled) {
              BlocProvider.of<AssetListBloc>(context).add(ToggleAsset(asset: asset));
            } else {
              AutoRouter.of(context).push(AssetCarouselPageRoute(albumId: albumId, initialAssetId: asset.id));
            }
          },
          onLongPress: () {
            // activate select mode and set this asset as selected
            if (!state.isSelectModeEnabled) {
              BlocProvider.of<AssetListBloc>(context).add(EnableSelectMode(initialSelectedAsset: asset));
            }
          },
          child: Stack(
            children: [
              AspectRatio(
                aspectRatio: 1,
                // child: ExtendedImage.network(
                //   asset.url,
                //   fit: BoxFit.cover,
                //   cache: true,
                // ),
                child: CachedNetworkImage(
                  imageUrl: asset.isVideo ? asset.thumbnailUrl : asset.url,
                  fit: BoxFit.cover,
                  // placeholder: (context, url) => Container(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              if (asset.isVideo) const Positioned(top: 0, left: 0, child: Icon(CupertinoIcons.video_camera_solid)),
              // if (asset.isVideo) Text(asset.duration.toString()),
              if (asset.isVideo)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Text(
                    _durationString(asset.duration),
                  ),
                ),
              if (isSelected)
                Container(
                  constraints: const BoxConstraints.expand(),
                  color: Colors.black.withOpacity(0.5),
                  child: Icon(size: 35.0, Icons.check_circle),
                ),
            ],
          ),
        );
      },
    );
  }
}
