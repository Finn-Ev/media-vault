import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_preview_card.dart';

class AssetList extends StatelessWidget {
  final String albumId;

  const AssetList({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openMenu({required selectedAssets}) {
      showModalBottomSheet(
          context: context,
          builder: (_) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('Export assets to device\'s gallery'),
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                        context: context,
                        builder: (_) {
                          return CustomAlertDialog(
                            title: 'Export',
                            content: 'Are you sure you want to export the selected assets into your device gallery?',
                            onConfirm: () {
                              BlocProvider.of<AssetControllerBloc>(context).add(ExportAssets(assetsToExport: selectedAssets));
                              BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                              // showDialog(
                              //   context: context,
                              //   builder: (_) => CustomAlertDialog(
                              //     title: 'Delete exported assets?',
                              //     content: 'Do you want to delete the exported assets from Media-Vault?',
                              //     onConfirm: () {
                              //       BlocProvider.of<AssetControllerBloc>(context).add(
                              //         DeleteAssets(albumId: albumId, assetsToDelete: selectedAssets),
                              //       );
                              //       BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                              //       Navigator.pop(context);
                              //     },
                              //   ),
                              // );
                            },
                          );
                        });
                  },
                ),
                ListTile(
                  title: const Text('Copy to another album'),
                  onTap: () {
                    Navigator.of(context).pop();
                    AutoRouter.of(context).push(MoveAssetsPageRoute(assets: selectedAssets, sourceAlbumId: albumId, copy: true));
                    BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                  },
                ),
                ListTile(
                  title: const Text('Move to another album'),
                  onTap: () {
                    Navigator.of(context).pop();
                    AutoRouter.of(context).push(MoveAssetsPageRoute(assets: selectedAssets, sourceAlbumId: albumId, copy: false));
                    BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                  },
                ),
                const SizedBox(height: 8),
              ],
            );
          });
    }

    return WillPopScope(
      onWillPop: () async {
        // workaround for now
        BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
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
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
                                                      albumId: albumId,
                                                    ),
                                                  );
                                                  BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                                                },
                                              ),
                                            );
                                          },
                                          child: const Icon(CupertinoIcons.delete)),
                                    Text("${assetListState.selectedAssets.length.toString()} selected"),
                                    if (assetListState.selectedAssets.isNotEmpty)
                                      GestureDetector(onTap: () => openMenu(selectedAssets: assetListState.selectedAssets), child: Icon(CupertinoIcons.share)),
                                  ],
                                ),
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
      ),
    );
  }
}
