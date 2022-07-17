import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_preview_card.dart';

class AssetList extends StatelessWidget {
  const AssetList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssetObserverBloc, AssetObserverState>(
      builder: (context, state) {
        if (state is AssetObserverInitial) {
          return Container();
        } else if (state is AssetObserverLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AssetObserverFailure) {
          return const Center(child: Text('Failed to load todos'));
        } else if (state is AssetObserverLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 3,
              children: state.assets.map((asset) {
                return AssetPreviewCard(asset: asset);
              }).toList(),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
