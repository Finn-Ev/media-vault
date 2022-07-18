import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_widget.dart';

import '../../../injection.dart';

class AssetListPage extends StatelessWidget {
  final Album album;
  const AssetListPage({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: album.id.value));
    final assetControllerBloc = BlocProvider.of<AssetControllerBloc>(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<AssetObserverBloc>(
          create: (context) => assetObserverBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCoreBloc, AuthCoreState>(
            listener: (context, state) {
              if (state is AuthCoreUnauthenticated) {
                AutoRouter.of(context).replace(const LoginPageRoute());
              }
            },
          ),
        ],
        child: BlocBuilder<AssetControllerBloc, AssetControllerState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(album.title),
                actions: [
                  if (state is AssetControllerInitial || state is AssetControllerLoaded)
                    PlatformPopupMenu(
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
                              assetControllerBloc.add(UploadImages(images: images, albumId: album.id));
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
                              assetControllerBloc.add(UploadVideo(video: video, albumId: album.id));
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
                    )
                  else
                    Container(),
                ],
              ),
              body: (state is AssetControllerLoading
                  ? Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LoadingIndicator(),
                        const SizedBox(height: 10),
                        state.currentStep >= 0 ? Text('Uploading asset: ${state.currentStep}/${state.totalSteps}') : Container(),
                      ],
                    ))
                  : AssetList(albumId: album.id.toString())),
            );
          },
        ),
      ),
    );
  }
}
