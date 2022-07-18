import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_preview_card.dart';

class AssetList extends StatelessWidget {
  final String albumId;

  const AssetList({required this.albumId, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetObserverBloc, AssetObserverState>(
      builder: (context, state) {
        if (state is AssetObserverInitial) {
          return Container();
        } else if (state is AssetObserverLoading) {
          return const Center(child: LoadingIndicator());
        } else if (state is AssetObserverFailure) {
          return const Center(child: Text('Failed to load todos'));
        } else if (state is AssetObserverLoaded && state.assets.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
              crossAxisCount: 3,
              children: state.assets.map((asset) {
                return AssetPreviewCard(asset: asset, albumId: albumId);
              }).toList(),
            ),
          );
        } else if (state is AssetObserverLoaded && state.assets.isEmpty) {
          return const Center(child: Text('This album is empty.'));
        } else {
          return Container();
        }
      },
    );
  }
}
