import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/controller/album_controller_bloc.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/application/auth/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_input_alert_dialog.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/album_list/widgets/album_list.dart';
import 'package:media_vault/presentation/media/album_list/widgets/trash_appbar_icon.dart';

import '../../../injection.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<AuthCoreBloc>(context).add(AuthCheckRequested());
    final albumObserverBloc = sl<AlbumObserverBloc>()..add(AlbumsObserveAll());

    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumObserverBloc>(
          create: (context) => albumObserverBloc,
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              AutoRouter.of(context).push(const SettingsRoute());
            },
          ),
          title: const Text('My Albums'),
          actions: [
            IconButton(
              icon: const Icon(
                // Icons.add,
                CupertinoIcons.add,
                size: 30,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) {
                    return CustomInputAlertDialog(
                      title: 'Create Album',
                      hintText: 'Enter the name of the album',
                      confirmText: 'Create',
                      popContextOnAction: true,
                      onConfirm: (value) {
                        BlocProvider.of<AlbumControllerBloc>(context).add(CreateAlbum(title: value));
                      },
                    );
                  },
                );
              },
            ),
            const TrashAppBarIcon()
          ],
        ),
        body: BlocBuilder<AlbumControllerBloc, AlbumControllerState>(
          builder: (context, state) {
            if (state is AlbumControllerLoading) {
              return const Center(child: LoadingIndicator());
            } else {
              // fully re-render the album-list every time the albums changes
              // otherwise the albums-sort-order will be buggy sometimes
              return BlocBuilder<AlbumObserverBloc, AlbumObserverState>(
                builder: (context, state) {
                  if (state is AlbumObserverLoaded) {
                    return state.albums.isNotEmpty
                        ? const AlbumList()
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  "You have no albums yet.",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  "Create one by tapping the + button.",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          );
                  } else {
                    return const Center(child: LoadingIndicator());
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }
}
