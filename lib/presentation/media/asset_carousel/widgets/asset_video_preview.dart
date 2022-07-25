import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/core/util/video_thumbnail.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:photo_view/photo_view.dart';

class AssetVideoPreview extends StatelessWidget {
  final Asset asset;
  const AssetVideoPreview({required this.asset, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: getThumbnail(asset),
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
                        onTap: () => AutoRouter.of(context).push(AssetVideoPlayerPageRoute(url: asset.url)),
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
