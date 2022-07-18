import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AssetPreviewCard extends StatelessWidget {
  final Asset asset;
  final String albumId;

  const AssetPreviewCard({required this.asset, required this.albumId, Key? key}) : super(key: key);

  Future<String> _previewImagePath() async {
    if (asset.isVideo) {
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

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: () {
        BlocProvider.of<AssetControllerBloc>(context).add(
          DeleteAsset(assetToDelete: asset, albumId: UniqueID.fromString(albumId)),
        );
      },
      child: Stack(
        textDirection: TextDirection.rtl,
        alignment: Alignment.bottomRight,
        children: [
          FutureBuilder<String>(
            future: _previewImagePath(),
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
          if (asset.isVideo) const Icon(CupertinoIcons.video_camera_solid),
        ],
      ),
    );
  }
}
