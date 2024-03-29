import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/features/assets/application/asset_list/asset_list_bloc.dart';
import 'package:media_vault/features/assets/application/controller/asset_controller_bloc.dart';
import 'package:media_vault/shared/widgets/custom_alert_dialog.dart';
import 'package:media_vault/shared/widgets/custom_modal_bottom_sheet.dart';

class TrashAssetListBottomMenu extends StatelessWidget {
  const TrashAssetListBottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void openModalSheetMenu({required selectedAssets}) {
      CustomModalBottomSheet.open(context: context, actions: [
        CustomModalBottomSheetAction(
            text: 'Move back to gallery',
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<AssetControllerBloc>(context)
                  .add(RemoveAssetsFromTrash(assets: selectedAssets));
              BlocProvider.of<AssetListBloc>(context).add(ResetAssetList());
            }),
      ]);
    }

    openDeleteDialog(selectedAssets) {
      showPlatformDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: selectedAssets.length > 1 ? "Delete assets" : "Delete asset",
          content: "Are you sure you want to delete all of the selected assets forever?",
          confirmIsDestructive: true,
          confirmButtonText: "Delete",
          onConfirm: () {
            BlocProvider.of<AssetControllerBloc>(context).add(
              DeleteAssetsPermanently(
                assetsToDelete: selectedAssets,
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
                  mainAxisAlignment: state.selectedAssets.isNotEmpty
                      ? MainAxisAlignment.spaceBetween
                      : MainAxisAlignment.center,
                  children: [
                    if (state.selectedAssets.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          openDeleteDialog(state.selectedAssets);
                        },
                        child: const Icon(CupertinoIcons.trash),
                      ),
                    Text("${state.selectedAssets.length} selected"),
                    if (state.selectedAssets.isNotEmpty)
                      GestureDetector(
                          onTap: () => openModalSheetMenu(selectedAssets: state.selectedAssets),
                          child: const Icon(CupertinoIcons.share)),
                  ],
                ))
            : Container();
      },
    );
  }
}
