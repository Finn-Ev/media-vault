import 'package:auto_route/auto_route.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class AssetVideoPlayer extends StatefulWidget {
  final String url;
  const AssetVideoPlayer({required this.url, Key? key}) : super(key: key);

  @override
  State<AssetVideoPlayer> createState() => _AssetVideoPlayerState();
}

class _AssetVideoPlayerState extends State<AssetVideoPlayer> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  void initState() {
    initializePlayer();
    super.initState();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.network(widget.url);

    await Future.wait([videoPlayerController.initialize()]);
    createChewieController();
    setState(() {});
  }

  void createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      looping: true,
      zoomAndPan: true,
      allowMuting: false,
      autoPlay: true,
      hideControlsTimer: const Duration(seconds: 2),
      playbackSpeeds: const [0.5, 1.0, 1.25, 1.5, 2.0],
    );
  }

  Future<String> _previewImagePath() async {
    final thumbnail = await VideoThumbnail.thumbnailFile(
      video: widget.url,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG,
    );

    if (thumbnail != null) {
      return thumbnail.toString();
    }
    return "";
  }

  openVideoPlayer() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => Scaffold(
          body: SafeArea(
            child: Center(
              child: Chewie(
                controller: chewieController!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: _previewImagePath(),
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
                    child: Center(child: GestureDetector(onTap: openVideoPlayer, child: Icon(size: 100, Icons.play_arrow_rounded))),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: InkResponse(
                      onTap: () => AutoRouter.of(context).pop(),
                      child: Icon(size: 30.0, Icons.close, color: Colors.grey),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const LoadingIndicator();
          }
        });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
