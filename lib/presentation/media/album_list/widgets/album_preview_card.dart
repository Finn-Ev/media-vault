import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/album_list/widgets/album_action_sheet.dart';

import '../../../../injection.dart';

class AlbumPreviewCard extends StatelessWidget {
  final Album album;

  const AlbumPreviewCard({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: album.id));

    return BlocProvider(
      create: (context) => assetObserverBloc,
      child: BlocBuilder<AssetObserverBloc, AssetObserverState>(
        builder: (context, state) {
          if (state is AssetObserverLoaded) {
            return InkResponse(
              onTap: () {
                AutoRouter.of(context).push(AssetListRoute(album: album));
              },
              onLongPress: () {
                showPlatformModalSheet(
                  context: context,
                  builder: (_) => AlbumActionSheet(album: album),
                );
              },
              child: Column(
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: state.assets.isEmpty
                        ? Container(
                            color: Colors.grey[850],
                            child: const Center(child: Icon(size: 50, CupertinoIcons.photo)),
                          )
                        : AspectRatio(
                            aspectRatio: 1,
                            child: CachedNetworkImage(
                              imageUrl: state.assets.first.isVideo ? state.assets.first.thumbnailUrl : state.assets.first.url,
                              fit: BoxFit.cover,
                              // placeholder: (context, url) => const LoadingIndicator(),
                              errorWidget: (context, url, error) => const Icon(Icons.error),
                            ),
                          ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
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
            return const Center(child: LoadingIndicator());
          }
        },
      ),
    );
  }
}
