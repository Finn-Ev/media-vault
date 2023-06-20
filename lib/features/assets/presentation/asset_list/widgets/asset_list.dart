import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/features/assets/application/asset_list/asset_list_bloc.dart';
import 'package:media_vault/features/assets/application/controller/asset_controller_bloc.dart';
import 'package:media_vault/features/assets/application/observer/asset_observer_bloc.dart';
import 'package:media_vault/features/assets/presentation/asset_list/trash/widgets/trash_asset_list_bottom_menu.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list_bottom_menu.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list_preview_card.dart';
import 'package:media_vault/shared/widgets/loading_indicator.dart';

class AssetList extends StatefulWidget {
  final String albumId;

  final bool isTrash;

  const AssetList({required this.albumId, this.isTrash = false, Key? key}) : super(key: key);

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

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return BlocListener<AssetControllerBloc, AssetControllerState>(
      listener: (context, state) {
        // scroll to the bottom of the list when the page is first loaded after the controller added assets to the asset-list
        if (state is AssetControllerInitial) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            scrollController.animateTo(
                // scrollController.position.hasContentDimensions
                //     ? scrollController.position.maxScrollExtent
                //     : 0,
                scrollController.position.maxScrollExtent,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOut);
          });
        }
      },
      child: BlocBuilder<AssetObserverBloc, AssetObserverState>(
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

                if (widget.albumId == trashAlbumId) {
                  // sort assets by the date they were deleted
                  assetObserverState.assets.sort((a, b) => a.modifiedAt.compareTo(b.modifiedAt));
                }

                return SafeArea(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: GridView.count(
                              controller: scrollController,
                              addAutomaticKeepAlives: true,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              crossAxisCount: 3,
                              children: assetObserverState.assets.map((asset) {
                                return AssetListPreviewCard(
                                  asset: asset,
                                  index: assetObserverState.assets.indexOf(asset),
                                  albumId: widget.albumId,
                                  isSelected: assetListState.selectedAssets.contains(asset),
                                );
                              }).toList(),
                            ),
                          ),
                          if (widget.albumId == trashAlbumId)
                            const TrashAssetListBottomMenu()
                          else
                            AssetListBottomMenu(albumId: widget.albumId),
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
                children: [
                  const Icon(
                    CupertinoIcons.photo,
                    size: 50,
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: Text(
                      widget.isTrash ? 'Trash is empty' : 'Add some assets by tapping on the camera button',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 50), // to move the text up a bit
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
