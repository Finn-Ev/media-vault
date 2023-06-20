import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/albums/application/observer/album_observer_bloc.dart';
import 'package:media_vault/features/assets/application/controller/asset_controller_bloc.dart';
import 'package:media_vault/features/assets/domain/entities/asset.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/routes/routes.gr.dart';

@RoutePage()
class MoveAssetsPage extends StatelessWidget {
  final String sourceAlbumId;
  final List<Asset> assets;
  final bool copy;

  const MoveAssetsPage({
    required this.sourceAlbumId,
    required this.assets,
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
                      if (copy) {
                        BlocProvider.of<AssetControllerBloc>(context).add(CopyAssets(
                          assetsToCopy: assets,
                          destinationAlbumId: album.id,
                        ));
                      } else {
                        BlocProvider.of<AssetControllerBloc>(context).add(
                          MoveAssets(
                            assetsToMove: assets,
                            sourceAlbumId: sourceAlbumId,
                            destinationAlbumId: album.id,
                          ),
                        );
                      }
                      AutoRouter.of(context).replace(const AlbumListRoute());
                      AutoRouter.of(context).push(AssetListRoute(album: album));
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
