import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/presentation/media/album_list/widgets/album_preview_card.dart';

class AlbumList extends StatelessWidget {
  const AlbumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AlbumObserverBloc, AlbumObserverState>(
      builder: (context, state) {
        if (state is AlbumObserverInitial) {
          return Container();
        } else if (state is AlbumObserverLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AlbumObserverFailure) {
          return const Center(child: Text('Failed to load todos'));
        } else if (state is AlbumObserverLoaded) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.count(
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              crossAxisCount: 2,
              childAspectRatio: .89,
              children: state.albums.map((album) {
                return AlbumPreviewCard(album: album);
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
