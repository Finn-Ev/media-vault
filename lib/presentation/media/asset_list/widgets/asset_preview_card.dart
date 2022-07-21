import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AssetPreviewCard extends StatelessWidget {
  final Asset asset;
  final String albumId;
  final bool isSelected;

  AssetPreviewCard({required this.asset, required this.albumId, required this.isSelected, Key? key}) : super(key: key);

  Future<String> _previewImagePath(isVideo) async {
    if (isVideo) {
      final thumbnail = await VideoThumbnail.thumbnailFile(
        video: asset.url,
        thumbnailPath: (await getTemporaryDirectory()).path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 300,
        maxHeight: 300,
      );

      if (thumbnail != null) {
        return thumbnail.toString();
      }
      return "";
    } else {
      return asset.url;
    }
  }

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
              // open asset carousel
            }
          },
          onLongPress: () {
            if (!state.isSelectModeEnabled) {
              BlocProvider.of<AssetListBloc>(context).add(EnableSelectMode(initialSelectedAsset: asset));
            }
            // activate select mode and set this asset as selected
          },
          child: Stack(
            children: [
              FutureBuilder<String>(
                future: _previewImagePath(asset.isVideo),
                builder: (context, snapshot) {
                  if (snapshot.hasData && asset.isVideo) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Image.asset(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else if (snapshot.hasData && !asset.isVideo) {
                    return AspectRatio(
                      aspectRatio: 1,
                      child: Image.network(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  } else {
                    return const Center(child: LoadingIndicator());
                  }
                },
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
