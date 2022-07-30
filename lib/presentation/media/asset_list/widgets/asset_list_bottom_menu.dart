import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/custom_modal_bottom_sheet.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AssetListBottomMenu extends StatelessWidget {
  final Album album;
  final bool albumIsEmpty;

  const AssetListBottomMenu({required this.album, Key? key, required this.albumIsEmpty}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetControllerBloc = BlocProvider.of<AssetControllerBloc>(context);

    void _pickAssets() async {
      final List<AssetEntity>? selectedAssets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 10,
          themeColor: Colors.grey[800],
          filterOptions: FilterOptionGroup(
            videoOption: const FilterOption(
              durationConstraint: DurationConstraint(
                min: Duration(seconds: 1),
                max: Duration(seconds: 180),
              ),
            ),
          ),
          loadingIndicatorBuilder: (BuildContext context, bool isSelected) {
            return const Center(child: LoadingIndicator());
          },
        ),
      );

      if (selectedAssets != null) {
        assetControllerBloc.add(UploadAssets(albumId: album.id, assets: selectedAssets));
      }
    }

    void _openModalSheetMenu({required selectedAssets}) {
      CustomModalBottomSheet.open(context: context, actions: [
        CustomModalBottomSheetAction(
            text: 'Export to gallery',
            onPressed: () {
              Navigator.pop(context);
              BlocProvider.of<AssetControllerBloc>(context).add(ExportAssets(assetsToExport: selectedAssets));
            }),
        CustomModalBottomSheetAction(
            text: 'Copy to another album',
            onPressed: () {
              Navigator.of(context).pop();
              AutoRouter.of(context).push(MoveAssetsPageRoute(assets: selectedAssets, sourceAlbumId: album.id, copy: true));
              BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
            }),
        CustomModalBottomSheetAction(
            text: 'Move to another album',
            onPressed: () {
              Navigator.of(context).pop();
              AutoRouter.of(context).push(MoveAssetsPageRoute(assets: selectedAssets, sourceAlbumId: album.id, copy: false));
              BlocProvider.of<AssetListBloc>(context).add(DisableSelectMode());
            })
      ]);
    }

    _openDeleteDialog(selectedAssets) {
      showPlatformDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: selectedAssets.length > 1 ? "Delete assets" : "Delete asset",
          content: "Are you sure you want to delete all of the ${selectedAssets.length} selected assets?",
          confirmIsDestructive: true,
          confirmButtonText: "Delete",
          onConfirm: () {
            BlocProvider.of<AssetControllerBloc>(context).add(
              DeleteAssets(
                assetsToDelete: selectedAssets,
                albumId: album.id,
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
        return SizedBox(
          height: 35,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
            child: state.isSelectModeEnabled
                ? Row(
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
                        GestureDetector(onTap: () => _openModalSheetMenu(selectedAssets: state.selectedAssets), child: const Icon(CupertinoIcons.share)),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: _pickAssets,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.only(top: 3.0),
                                child: Text("Upload assets"),
                              ),
                              Icon(
                                Icons.add,
                                size: 24,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
