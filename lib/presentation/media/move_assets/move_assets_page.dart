import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/domain/entities/media/asset.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';

import '../../../injection.dart';

class MoveAssetsPage extends StatelessWidget {
  final String sourceAlbumId;
  final List<Asset> assetsToMove;
  final bool copy;

  const MoveAssetsPage({
    required this.sourceAlbumId,
    required this.assetsToMove,
    required this.copy,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final albumObserver = sl<AlbumObserverBloc>()..add(AlbumsObserveAll());
    return BlocProvider(
      create: (context) => albumObserver,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Choose an album'),
        ),
        body: BlocBuilder<AlbumObserverBloc, AlbumObserverState>(
          builder: (context, state) {
            if (state is AlbumObserverLoaded) {
              return ListView.builder(
                itemCount: state.albums.length,
                itemBuilder: (context, index) {
                  final album = state.albums[index];

                  if (album.id == sourceAlbumId) {
                    // source album can't be the destination album
                    return Container();
                  }

                  return ListTile(
                    title: Text(album.title),
                    onTap: () {
                      BlocProvider.of<AssetControllerBloc>(context).add(
                        MoveAssets(
                          assetsToMove: assetsToMove,
                          sourceAlbumId: sourceAlbumId,
                          destinationAlbumId: album.id,
                          keepAssets: copy,
                        ),
                      );
                      AutoRouter.of(context).replace(const AlbumListPageRoute());
                      AutoRouter.of(context).push(AssetListPageRoute(album: album));
                    },
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
