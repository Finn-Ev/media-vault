import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_bottom_menu.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_preview_card.dart';

class AssetList extends StatefulWidget {
  final Album album;

  const AssetList({required this.album, Key? key}) : super(key: key);

  @override
  State<AssetList> createState() => _AssetListState();
}

class _AssetListState extends State<AssetList> {
  bool cachedImagesHaveBeenLoaded = false;

  // it takes around 1 second to load the cached images
  void startLoadingCachedImages() {
    Timer(const Duration(milliseconds: 1000), () {
      setState(() {
        cachedImagesHaveBeenLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<AssetObserverBloc, AssetObserverState>(
      builder: (context, assetObserverState) {
        if (assetObserverState is AssetObserverInitial) {
          return Container();
        } else if (assetObserverState is AssetObserverLoading) {
          return const Center(child: LoadingIndicator());
        } else if (assetObserverState is AssetObserverFailure) {
          return const Center(child: Text('Failed to load assets'));
        } else if (assetObserverState is AssetObserverLoaded && assetObserverState.assets.isNotEmpty) {
          return BlocBuilder<AssetListBloc, AssetListState>(
            builder: (context, assetListState) {
              if (!cachedImagesHaveBeenLoaded) startLoadingCachedImages();
              return SafeArea(
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: GridView.count(
                            addAutomaticKeepAlives: true,
                            crossAxisSpacing: 6,
                            mainAxisSpacing: 6,
                            crossAxisCount: 3,
                            children: assetObserverState.assets.map((asset) {
                              return AssetListPreviewCard(
                                asset: asset,
                                albumId: widget.album.id,
                                isSelected: assetListState.selectedAssets.contains(asset),
                              );
                            }).toList(),
                          ),
                        ),
                        AssetListBottomMenu(album: widget.album, albumIsEmpty: false)
                      ],
                    ),
                    if (!cachedImagesHaveBeenLoaded)
                      Container(
                        color: themeData.scaffoldBackgroundColor,
                        constraints: const BoxConstraints.expand(),
                        child: const Center(
                          child: LoadingIndicator(),
                        ),
                      )
                  ],
                ),
              );
            },
          );
        } else if (assetObserverState is AssetObserverLoaded && assetObserverState.assets.isEmpty) {
          return Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        CupertinoIcons.photo,
                        size: 50,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'This album is empty',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ),
              AssetListBottomMenu(album: widget.album, albumIsEmpty: true)
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
