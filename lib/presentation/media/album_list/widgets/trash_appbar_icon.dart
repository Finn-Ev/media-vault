import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/constants.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

import '../../../../injection.dart';

class TrashAppBarIcon extends StatelessWidget {
  const TrashAppBarIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: trashAlbumId));
    return BlocProvider(
      create: (context) => assetObserverBloc,
      child: BlocConsumer<AssetObserverBloc, AssetObserverState>(
        listener: (context, state) {
          if (state is AssetObserverLoaded) {
            final outdatedAssets = state.assets
                .where((asset) => asset.modifiedAt.isBefore(DateTime.now().subtract(const Duration(days: 7))))
                .toList();

            BlocProvider.of<AssetControllerBloc>(context)
                .add(DeleteAssetsPermanently(assetsToDelete: outdatedAssets));
          }
        },
        builder: (context, state) {
          if (state is AssetObserverLoaded) {
            final trashAlbumAssetCount = state.assets.length.toString();
            return Center(
              child: Stack(
                children: [
                  IconButton(
                    onPressed: () {
                      AutoRouter.of(context).push(const TrashRoute());
                    },
                    icon: const Icon(CupertinoIcons.trash),
                  ),
                  Positioned(top: 0, right: 3, child: Text(trashAlbumAssetCount)),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
