import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_carousel/widgets/asset_carousel.dart';

import '../../../injection.dart';

class AssetCarouselPage extends StatefulWidget {
  final String albumId;
  final String initialAssetId;

  const AssetCarouselPage({required this.albumId, required this.initialAssetId, Key? key}) : super(key: key);

  @override
  State<AssetCarouselPage> createState() => _AssetCarouselPageState();
}

class _AssetCarouselPageState extends State<AssetCarouselPage> {
  bool showUI = true;

  void toggleUI() {
    setState(() {
      showUI = true;
      Timer(const Duration(milliseconds: 3000), () {
        if (mounted) {
          showUI = false;
        }
      });
    });
  }

  @override
  void initState() {
    Timer(const Duration(milliseconds: 3000), () {
      if (mounted) {
        setState(() {
          showUI = false;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: widget.albumId));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AssetObserverBloc>(
          create: (context) => assetObserverBloc,
        ),
      ],
      child: BlocBuilder<AssetControllerBloc, AssetControllerState>(
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              toggleUI();
            },
            child: Scaffold(
              body: (state is AssetControllerLoading
                  ? const Center(child: LoadingIndicator())
                  : SafeArea(
                      child: Stack(
                        children: [
                          AssetCarousel(
                            albumId: widget.albumId,
                            initialAssetId: widget.initialAssetId,
                          ),
                          showUI
                              ? Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    // decoration: const BoxDecoration(
                                    //   color: Colors.white,
                                    //   borderRadius: BorderRadius.all(Radius.circular(100)),
                                    // ),
                                    child: InkResponse(
                                      onTap: () => AutoRouter.of(context).pop(),
                                      child: Icon(size: 30.0, Icons.close, color: Colors.grey),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    )),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
