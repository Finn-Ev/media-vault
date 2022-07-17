import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

import '../../../../injection.dart';

class AlbumPreviewCard extends StatelessWidget {
  final Album album;

  const AlbumPreviewCard({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: album.id.value));
    return BlocProvider(
      create: (context) => assetObserverBloc,
      child: BlocBuilder<AssetObserverBloc, AssetObserverState>(
        builder: (context, state) {
          if (state is AssetObserverLoaded) {
            return InkResponse(
              onTap: () {
                AutoRouter.of(context).push(AssetListPageRoute(album: album));
              },
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Image.network(
                        state.assets.isNotEmpty ? state.assets.last.url : "https://songline-marketing.de/wp-content/uploads/2021/08/image-placeholder.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(album.title),
                      const SizedBox(
                        width: 8.0,
                        height: 8.0,
                      ),
                      Text(
                        state.assets.length.toString(),
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
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
