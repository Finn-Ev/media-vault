import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/assets/application/asset_list/asset_list_bloc.dart';
import 'package:media_vault/features/assets/application/observer/asset_observer_bloc.dart';

class AssetListAppBarActions extends StatelessWidget {
  final String albumId;

  const AssetListAppBarActions({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetListBloc = BlocProvider.of<AssetListBloc>(context);

    return BlocBuilder<AssetObserverBloc, AssetObserverState>(
      builder: (context, assetObserverState) {
        final bool showUI = assetObserverState is AssetObserverLoaded && assetObserverState.assets.isNotEmpty;

        if (showUI) {
          return BlocBuilder<AssetListBloc, AssetListState>(
            builder: (context, assetListState) {
              if (assetListState.isSelectModeEnabled) {
                return InkResponse(
                  onTap: () {
                    assetListBloc.add(DisableSelectMode());
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Text("Cancel"),
                      ),
                    ],
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {
                    assetListBloc.add(EnableSelectMode());
                  },
                  child: const Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 12.0),
                        child: Text("Select"),
                      ),
                    ],
                  ),
                );
              }
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
