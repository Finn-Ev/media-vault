import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/infrastructure/repositories/asset_repository_impl.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_preview_card.dart';
import 'package:media_vault/presentation/media/trash/widgets/trash_asset_list_bottom_menu.dart';

class TrashAssetList extends StatefulWidget {
  const TrashAssetList({Key? key}) : super(key: key);

  @override
  State<TrashAssetList> createState() => _TrashAssetListState();
}

class _TrashAssetListState extends State<TrashAssetList> {
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
                                index: assetObserverState.assets.indexOf(asset),
                                albumId: trashAlbumId,
                                isSelected: assetListState.selectedAssets.contains(asset),
                              );
                            }).toList(),
                          ),
                        ),
                        const TrashAssetListBottomMenu(),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  CupertinoIcons.trash,
                  size: 50,
                ),
                SizedBox(height: 8),
                Text(
                  'The trash is empty',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
