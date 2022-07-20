import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/domain/entities/auth/user_id.dart';

class AssetListAppBarActions extends StatelessWidget {
  final UniqueID albumId;

  const AssetListAppBarActions({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();

    final assetControllerBloc = BlocProvider.of<AssetControllerBloc>(context);
    final assetListBloc = BlocProvider.of<AssetListBloc>(context);

    return BlocBuilder<AssetListBloc, AssetListState>(
      builder: (context, state) {
        if (state.isSelectModeEnabled) {
          return InkResponse(
            onTap: () {
              assetListBloc.add(DisableSelectMode());
            },
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Cancel"),
              ],
            ),
          );
        } else {
          return PlatformPopupMenu(
            options: [
              PopupMenuOption(
                label: 'Add Images',
                cupertino: (_, __) => CupertinoPopupMenuOptionData(
                  child: const Text(
                    'Upload Images',
                    style: TextStyle(color: CupertinoColors.activeBlue),
                  ),
                ),
                onTap: (_) async {
                  final List<XFile>? images = await picker.pickMultiImage();
                  if (images != null) {
                    assetControllerBloc.add(UploadImages(images: images, albumId: albumId));
                  }
                },
              ),
              PopupMenuOption(
                label: 'Add Video',
                cupertino: (_, __) => CupertinoPopupMenuOptionData(
                  child: const Text(
                    'Upload Video',
                    style: TextStyle(color: CupertinoColors.activeBlue),
                  ),
                ),
                onTap: (_) async {
                  final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
                  if (video != null) {
                    assetControllerBloc.add(UploadVideo(video: video, albumId: albumId));
                  }
                },
              ),
              PopupMenuOption(
                label: 'Cancel',
                cupertino: (_, __) => CupertinoPopupMenuOptionData(
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: CupertinoColors.destructiveRed),
                  ),
                ),
              ),
            ],
            icon: const Icon(Icons.add),
          );
        }
      },
    );
  }
}
