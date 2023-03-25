import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class UploadAssetsFloatingButton extends StatelessWidget {
  final String albumId;

  const UploadAssetsFloatingButton({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final assetControllerBloc = BlocProvider.of<AssetControllerBloc>(context);
    void pickAssets() async {
      final List<AssetEntity>? selectedAssets = await AssetPicker.pickAssets(
        context,
        pickerConfig: AssetPickerConfig(
          maxAssets: 12,
          themeColor: Colors.grey[800],
          specialPickerType: SpecialPickerType.noPreview,
          pageSize: 24,
          gridCount: 3,
          filterOptions: FilterOptionGroup(
            videoOption: const FilterOption(
              durationConstraint: DurationConstraint(
                min: Duration(seconds: 1),
                max: Duration(seconds: 60),
              ),
            ),
          ),
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
          return GestureDetector(
            onTap: pickAssets,
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                border: Border.all(
                  color: themeData.colorScheme.onPrimary,
                  width: 2,
                ),
                color: themeData.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Icon(
                    Icons.add_a_photo_outlined,
                    size: 40,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
