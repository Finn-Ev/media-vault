import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_carousel/asset_carousel_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';

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
            content: 'Are you sure you want to delete this asset?',
            onConfirm: () {
              BlocProvider.of<AssetControllerBloc>(context).add(DeleteAssets(albumId: UniqueID.fromString(albumId), assetsToDelete: [currentAsset]));
              if (lastAlbumAssetIsViewedInCarousel) {
                BlocProvider.of<AssetCarouselBloc>(context).add(CarouselIndexChanged(newIndex: -1));
              }
            },
            confirmIsDestructive: true,
            confirmButtonText: 'Delete',
          );
        },
      );
    }

    void exportAsset() {
      showDialog(
          context: context,
          builder: (_) {
            return CustomAlertDialog(
              title: 'Export',
              content: 'Are you sure you want to export this asset into your device gallery?',
              onConfirm: () {
                BlocProvider.of<AssetControllerBloc>(context).add(ExportAssets(assetsToExport: [currentAsset]));
              },
            );
          });
    }

    final themeData = Theme.of(context);
    return BlocListener<AssetControllerBloc, AssetControllerState>(
      listenWhen: (previous, current) =>
          (previous is AssetControllerLoading && current is AssetControllerFailure) || (previous is AssetControllerLoading && current is AssetControllerLoaded),
      listener: (context, state) {
        if (state is AssetControllerLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'The asset was exported successfully',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ));
        }
        if (state is AssetControllerFailure) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'There was an error exporting the asset. Please try again',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ));
        }
      },
      child: BlocBuilder<AssetCarouselBloc, AssetCarouselState>(
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
                            onTap: exportAsset,
                            child: const Icon(CupertinoIcons.share),
                          ),
                        ],
                      ),
                    ),
                  ))
              : Container();
        },
      ),
    );
  }
}
