import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/features/albums/application/observer/album_observer_bloc.dart';
import 'package:media_vault/features/assets/application/asset_list/asset_list_bloc.dart';
import 'package:media_vault/features/assets/application/controller/asset_controller_bloc.dart';
import 'package:media_vault/features/assets/application/observer/asset_observer_bloc.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list_app_bar_actions.dart';
import 'package:media_vault/features/assets/presentation/asset_list/widgets/asset_list_leading_action.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/shared/widgets/loading_indicator.dart';

@RoutePage()
class TrashPage extends StatelessWidget {
  const TrashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: trashAlbumId));
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
        child: BlocBuilder<AssetControllerBloc, AssetControllerState>(
          builder: (context, assetControllerState) {
            return BlocBuilder<AssetListBloc, AssetListState>(
              builder: (context, assetListState) {
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Trash"),
                    centerTitle: true,
                    leadingWidth: assetListState.isSelectModeEnabled ? 90 : 56,
                    leading: assetControllerState is! AssetControllerLoading && assetListState.isSelectModeEnabled
                        ? const AssetListLeadingAction(albumId: trashAlbumId)
                        : null,
                    actions: [
                      if (assetControllerState is! AssetControllerLoading)
                        const AssetListAppBarActions(
                          albumId: trashAlbumId,
                        )
                    ],
                  ),
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
                      : const AssetList(
                          albumId: trashAlbumId,
                          isTrash: true,
                        )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
