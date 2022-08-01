import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_modal_bottom_sheet.dart';

class AssetCarouselBottomMenu extends StatelessWidget {
  final String albumId;
  final Asset currentAsset;
  final bool lastAlbumAssetIsViewedInCarousel;
  const AssetCarouselBottomMenu({
    required this.albumId,
    required this.currentAsset,
    required this.lastAlbumAssetIsViewedInCarousel,
    Key? key,
  }) : super(key: key);

  void openDiaShowMenu() {}

  @override
  Widget build(BuildContext context) {
    void deleteAsset() {
      showDialog(
        context: context,
        builder: (_) {
          return CustomAlertDialog(
            title: 'Delete',
            content: 'Are you sure you want to move this asset to the trash-bin?',
            onConfirm: () {
              BlocProvider.of<AssetControllerBloc>(context).add(MoveAssetsToTrash(
                sourceAlbumId: albumId,
                assetsToMove: [currentAsset],
              ));
              if (lastAlbumAssetIsViewedInCarousel) {
                BlocProvider.of<AssetCarouselBloc>(context).add(CarouselIndexChanged(newIndex: -1));
              }
              Navigator.of(context).pop();
            },
            confirmIsDestructive: true,
            confirmButtonText: 'Delete',
          );
        },
      );
    }

    void openAssetMenu() {
      bool showMoveCopyActions = false;
      if ((BlocProvider.of<AlbumObserverBloc>(context).state as AlbumObserverLoaded).albums.length > 1) {
        showMoveCopyActions = true;
      }
      return CustomModalBottomSheet.open(
        context: context,
        actions: [
          CustomModalBottomSheetAction(
              text: "Export asset",
              onPressed: () {
                Navigator.pop(context);
                showDialog(
                    context: context,
                    builder: (_) {
                      return CustomAlertDialog(
                        title: 'Export',
                        content: 'Are you sure you want to export this asset into your device gallery?',
                        onConfirm: () {
                          BlocProvider.of<AssetControllerBloc>(context).add(ExportAssets(assetsToExport: [currentAsset]));
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Asset exported'),
                            ),
                          );
                        },
                      );
                    });
              }),
          if (showMoveCopyActions)
            CustomModalBottomSheetAction(
                text: "Copy asset",
                onPressed: () {
                  AutoRouter.of(context).push(MoveAssetsRoute(assets: [currentAsset], sourceAlbumId: albumId, copy: true));
                  BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                }),
          if (showMoveCopyActions)
            CustomModalBottomSheetAction(
                text: "Move asset",
                onPressed: () {
                  AutoRouter.of(context).push(MoveAssetsRoute(assets: [currentAsset], sourceAlbumId: albumId, copy: false));
                  BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
                }),
        ],
      );
    }

    final themeData = Theme.of(context);
    return BlocBuilder<AssetCarouselBloc, AssetCarouselState>(
      builder: (context, state) {
        return state.showMenuUI
            ? Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: 0.0,
                child: Container(
                  color: themeData.scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(onTap: deleteAsset, child: const Icon(CupertinoIcons.delete)),
                        GestureDetector(onTap: openDiaShowMenu, child: const Icon(CupertinoIcons.play_arrow)),
                        GestureDetector(
                          onTap: openAssetMenu,
                          child: const Icon(CupertinoIcons.share),
                        ),
                      ],
                    ),
                  ),
                ))
            : Container();
      },
    );
  }
}
