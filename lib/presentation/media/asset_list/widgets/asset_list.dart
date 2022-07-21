import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_preview_card.dart';

class AssetList extends StatelessWidget {
  final String albumId;

  const AssetList({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              return SafeArea(
                child: Column(
                  children: [
                    Expanded(
                      child: GridView.count(
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        crossAxisCount: 3,
                        children: assetObserverState.assets.map((asset) {
                          return AssetPreviewCard(
                            asset: asset,
                            albumId: albumId,
                            isSelected: assetListState.selectedAssets.contains(asset),
                          );
                        }).toList(),
                      ),
                    ),
                    assetListState.isSelectModeEnabled
                        ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: assetListState.selectedAssets.isNotEmpty ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                              children: [
                                if (assetListState.selectedAssets.isNotEmpty)
                                  InkResponse(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (_) => CustomAlertDialog(
                                            title: assetListState.selectedAssets.length > 1 ? "Delete assets" : "Delete asset",
                                            content: "Are you sure you want to delete all of the ${assetListState.selectedAssets.length} selected assets?",
                                            confirmIsDestructive: true,
                                            confirmButtonText: "Delete",
                                            onConfirm: () {
                                              BlocProvider.of<AssetControllerBloc>(context).add(
                                                DeleteAssets(
                                                  assetsToDelete: assetListState.selectedAssets,
                                                  albumId: UniqueID.fromString(albumId),
                                                ),
                                              );
                                              BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                                            },
                                          ),
                                        );
                                      },
                                      child: const Text("Delete")),
                                Text("${assetListState.selectedAssets.length.toString()} selected"),
                                if (assetListState.selectedAssets.isNotEmpty) const Text("Share"),
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ),
              );
            },
          );
        } else if (assetObserverState is AssetObserverLoaded && assetObserverState.assets.isEmpty) {
          return const Center(child: Text('This album is empty.'));
        } else {
          return Container();
        }
      },
    );
  }
}
