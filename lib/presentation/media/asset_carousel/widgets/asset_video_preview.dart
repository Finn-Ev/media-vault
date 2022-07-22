import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AssetVideoPreview extends StatelessWidget {
  final String url;
  const AssetVideoPreview({required this.url, Key? key}) : super(key: key);

  Future<String> _videoPreviewPath() async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
    );

    if (thumbnail != null) {
      return thumbnail.toString();
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _videoPreviewPath(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: Stack(
                children: [
                  PhotoView(imageProvider: AssetImage(snapshot.data!)),
                  Container(
                    constraints: const BoxConstraints.expand(),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Center(
                      child: GestureDetector(
                        onTap: () => AutoRouter.of(context).push(AssetVideoPlayerRoute(url: url)),
                        child: Icon(size: 100, Icons.play_arrow_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const LoadingIndicator();
          }
        });
  }
}
