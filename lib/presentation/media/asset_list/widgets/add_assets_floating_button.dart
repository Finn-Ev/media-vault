import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AddAssetsFloatingButton extends StatelessWidget {
  final UniqueID albumId;

  AddAssetsFloatingButton({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetControllerBloc = BlocProvider.of<AssetControllerBloc>(context);

    void _pickAssets() async {
      final List<AssetEntity>? selectedAssets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 10,
          themeColor: Colors.grey[800],
          loadingIndicatorBuilder: (BuildContext context, bool isSelected) {
            return const Center(child: LoadingIndicator());
          },
        ),
      );

      if (selectedAssets != null) {
        assetControllerBloc.add(UploadAssets(albumId: albumId, assets: selectedAssets));
      }
    }

    return BlocBuilder<AssetListBloc, AssetListState>(
      builder: (context, state) {
        if (!state.isSelectModeEnabled) {
          return InkResponse(
            onTap: _pickAssets,
            child: Icon(size: 45, CupertinoIcons.add_circled_solid),
          );
        } else {
          return Container();
        }
      },
    );
  }
}