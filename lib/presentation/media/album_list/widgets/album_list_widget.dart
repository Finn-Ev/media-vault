import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';

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
            child: ListView.builder(
              itemCount: state.albums.length,
              itemBuilder: (context, index) {
                return Text(
                  state.albums[index].title,
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
