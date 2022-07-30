import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_bottom_menu.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_preview_card.dart';

class AssetList extends StatelessWidget {
  final Album album;

  const AssetList({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
        BlocProvider.of<AssetControllerBloc>(context).add(ResetAssetController());
        return true;
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
                if (assetListState.sortByOldestFirst) {
                  assetObserverState.assets.sort((a, b) => a.uploadedAt.compareTo(b.uploadedAt));
                } else {
                  assetObserverState.assets.sort((a, b) => b.uploadedAt.compareTo(a.uploadedAt));
                }
                return SafeArea(
                  child: Column(
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
                              albumId: album.id,
                              isSelected: assetListState.selectedAssets.contains(asset),
                            );
                          }).toList(),
                        ),
                      ),
                      AssetListBottomMenu(album: album, albumIsEmpty: false)
                    ],
                  ),
                );
              },
            );
          } else if (assetObserverState is AssetObserverLoaded && assetObserverState.assets.isEmpty) {
            return SafeArea(
              child: Column(
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
                  AssetListBottomMenu(album: album, albumIsEmpty: true)
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
