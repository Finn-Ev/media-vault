import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_modal_bottom_sheet.dart';

class AssetListBottomMenu extends StatelessWidget {
  final String albumId;

  const AssetListBottomMenu({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _openModalSheetMenu({required selectedAssets}) {
      bool showMoveCopyActions = false;
      if (BlocProvider.of<AssetObserverBloc>(context).state is AssetObserverLoaded &&
          (BlocProvider.of<AlbumObserverBloc>(context).state as AlbumObserverLoaded).albums.length > 1) {
        showMoveCopyActions = true;
      }

      CustomModalBottomSheet.open(context: context, actions: [
        CustomModalBottomSheetAction(
            text: 'Export to gallery',
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<AssetControllerBloc>(context).add(ExportAssets(assetsToExport: selectedAssets));
            }),
        if (showMoveCopyActions)
          CustomModalBottomSheetAction(
              text: 'Copy to another album',
              onPressed: () {
                Navigator.of(context).pop();
                AutoRouter.of(context).push(MoveAssetsRoute(assets: selectedAssets, sourceAlbumId: albumId, copy: true));
                BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
              }),
        if (showMoveCopyActions)
          CustomModalBottomSheetAction(
              text: 'Move to another album',
              onPressed: () {
                Navigator.of(context).pop();
                AutoRouter.of(context).push(MoveAssetsRoute(assets: selectedAssets, sourceAlbumId: albumId, copy: false));
                BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
              })
      ]);
    }

    _openDeleteDialog(selectedAssets) {
      showPlatformDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: selectedAssets.length > 1 ? "Delete assets" : "Delete asset",
          content: "Are you sure you want to move all of the selected assets to the trash-bin?",
          confirmIsDestructive: true,
          confirmButtonText: "Delete",
          onConfirm: () {
            BlocProvider.of<AssetControllerBloc>(context).add(
              MoveAssetsToTrash(
                assetsToMove: selectedAssets,
                sourceAlbumId: albumId,
              ),
            );
            BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
            Navigator.pop(context);
          },
        ),
      );
    }

    return BlocBuilder<AssetListBloc, AssetListState>(
      builder: (context, state) {
        return state.isSelectModeEnabled
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: state.selectedAssets.isNotEmpty ? MainAxisAlignment.spaceBetween : MainAxisAlignment.center,
                  children: [
                    if (state.selectedAssets.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _openDeleteDialog(state.selectedAssets);
                        },
                        child: const Icon(CupertinoIcons.delete),
                      ),
                    Text("${state.selectedAssets.length} selected"),
                    if (state.selectedAssets.isNotEmpty)
                      GestureDetector(
                          onTap: () => _openModalSheetMenu(selectedAssets: state.selectedAssets),
                          child: const Icon(CupertinoIcons.share)),
                  ],
                ))
            : Container();
      },
    );
  }
}
