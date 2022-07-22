import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:video_player/video_player.dart';

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
  initState() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: chewieController != null && chewieController!.videoPlayerController.value.isInitialized
              ? Chewie(controller: chewieController!)
              : const Center(child: LoadingIndicator()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController?.dispose();
    super.dispose();
  }
}
