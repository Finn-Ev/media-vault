import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/features/albums/application/observer/album_observer_bloc.dart';
import 'package:media_vault/features/albums/domain/entities/album.dart';
import 'package:media_vault/features/assets/application/asset_list/asset_list_bloc.dart';
import 'package:media_vault/features/assets/application/controller/asset_controller_bloc.dart';
import 'package:media_vault/features/assets/application/observer/asset_observer_bloc.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list_app_bar_actions.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list_leading_action.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/upload_assets_floating_button.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/routes/routes.gr.dart';
import 'package:media_vault/shared/widgets/custom_alert_dialog.dart';
import 'package:media_vault/shared/widgets/loading_indicator.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

@RoutePage()
class AssetListPage extends StatelessWidget {
  final Album album;

  const AssetListPage({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: album.id));
    final albumObserverBloc = sl<AlbumObserverBloc>()..add(AlbumsObserveAll());

    resetAssetListPage() {
      BlocProvider.of<AssetListBloc>(context).add(ResetAssetList());
      BlocProvider.of<AssetControllerBloc>(context).add(ResetAssetController());
    }

    return WillPopScope(
      onWillPop: () async {
        resetAssetListPage();
        return true;
      },
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AssetObserverBloc>(
            create: (context) => assetObserverBloc,
          ),
          BlocProvider<AlbumObserverBloc>(
            create: (context) => albumObserverBloc,
          ),
        ],
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthCoreBloc, AuthCoreState>(
              listener: (context, state) {
                if (state is AuthCoreUnauthenticated) {
                  AutoRouter.of(context).replace(const LoginRoute());
                }
              },
            ),
          ],
          child: BlocBuilder<AssetControllerBloc, AssetControllerState>(
            builder: (context, assetControllerState) {
              if (assetControllerState is AssetControllerLoaded) {
                if (assetControllerState.action == AssetControllerLoadedActions.export) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    showPlatformDialog(
                      context: context,
                      builder: (_) {
                        return CustomAlertDialog(
                          title: 'Export successful',
                          content: 'Do you want to delete the exported assets from Media-Vault?',
                          onConfirm: () {
                            BlocProvider.of<AssetControllerBloc>(context).add(
                              MoveAssetsToTrash(
                                sourceAlbumId: album.id,
                                assetsToMove: BlocProvider.of<AssetListBloc>(context).state.selectedAssets,
                              ),
                            );
                            resetAssetListPage();
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  });
                }
                if (assetControllerState.action == AssetControllerLoadedActions.upload) {
                  final assetIds = List<String>.from(assetControllerState.payload);

                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    showPlatformDialog(
                      context: context,
                      builder: (_) {
                        return CustomAlertDialog(
                          title: 'Delete uploaded assets?',
                          content: 'Continue if you want to delete the uploaded assets from your device.',
                          confirmButtonText: 'Continue',
                          onConfirm: () {
                            PhotoManager.editor.deleteWithIds(assetIds);
                            Navigator.pop(context);
                            resetAssetListPage();
                          },
                          onCancel: () {
                            Navigator.pop(context);
                            resetAssetListPage();
                          },
                        );
                      },
                    );
                  });
                }
              }

              return BlocBuilder<AssetListBloc, AssetListState>(
                builder: (context, assetListState) {
                  return Scaffold(
                    appBar: AppBar(
                      title: Text(album.title),
                      leadingWidth: assetListState.isSelectModeEnabled ? 90 : 56, // 56 is flutter-default
                      leading: assetControllerState is! AssetControllerLoading && assetListState.isSelectModeEnabled
                          ? AssetListLeadingAction(albumId: album.id)
                          : null,
                      actions: [
                        if (assetControllerState is! AssetControllerLoading)
                          AssetListAppBarActions(
                            albumId: album.id,
                          )
                      ],
                    ),
                    floatingActionButton: assetControllerState is! AssetControllerLoading
                        ? UploadAssetsFloatingButton(
                            albumId: album.id,
                          )
                        : null,
                    body: (assetControllerState is AssetControllerLoading
                        ? Center(
                            child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const LoadingIndicator(),
                              const SizedBox(height: 10),
                              Text(assetControllerState.message),
                            ],
                          ))
                        : AssetList(albumId: album.id)),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
