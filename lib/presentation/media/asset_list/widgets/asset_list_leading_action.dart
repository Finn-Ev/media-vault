import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';

class AssetListLeadingAction extends StatelessWidget {
  final String albumId;

  const AssetListLeadingAction({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetListBloc = BlocProvider.of<AssetListBloc>(context);

    return BlocBuilder<AssetObserverBloc, AssetObserverState>(
      builder: (context, assetObserverState) {
        final bool showUI = assetObserverState is AssetObserverLoaded && assetObserverState.assets.isNotEmpty;

        if (showUI) {
          return BlocBuilder<AssetListBloc, AssetListState>(builder: (context, assetListState) {
            if (assetListState.isSelectModeEnabled) {
              return InkResponse(
                onTap: () {
                  assetListBloc.add(AddAllAssets(assets: assetObserverState.assets));
                },
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text("Select all"),
                  ],
                ),
              );
            } else {
              return Container();
            }
          });
        } else {
          return Container();
        }
      },
    );
  }
}
