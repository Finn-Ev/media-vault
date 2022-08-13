import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:video_player/video_player.dart';

class AssetVideoPlayerPage extends StatefulWidget {
  final String url;
  const AssetVideoPlayerPage({required this.url, Key? key}) : super(key: key);

  @override
  State<AssetVideoPlayerPage> createState() => _AssetVideoPlayerPageState();
}

class _AssetVideoPlayerPageState extends State<AssetVideoPlayerPage> {
  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  @override
  initState() {
    initializePlayer();
    super.initState();
  }

  Future<void> initializePlayer() async {
    videoPlayerController = await getVideoController();

    await Future.wait([videoPlayerController.initialize()]);
    createChewieController();
    setState(() {});
  }

  void createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      // looping: true,
      zoomAndPan: true,
      allowMuting: false,
      autoPlay: true,

      hideControlsTimer: const Duration(seconds: 2),
      playbackSpeeds: const [0.5, 1.0, 1.25, 1.5, 2.0],
    );
  }

  Future<VideoPlayerController> getVideoController() async {
    final cacheManager = DefaultCacheManager();
    final fileInfo = await DefaultCacheManager().getFileFromCache(widget.url);

    if (fileInfo == null) {
      print('[VideoControllerService]: No video in cache');
      //
      print('[VideoControllerService]: Saving video to cache');
      unawaited(cacheManager.downloadFile(widget.url));

      return VideoPlayerController.network(widget.url);
    } else {
      print('[VideoControllerService]: Loading video from cache');
      return VideoPlayerController.file(fileInfo.file);
    }
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
