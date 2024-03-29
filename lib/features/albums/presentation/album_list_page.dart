import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/features/albums/application/controller/album_controller_bloc.dart';
import 'package:media_vault/features/albums/application/observer/album_observer_bloc.dart';
import 'package:media_vault/features/albums/presentation/widgets/album_list.dart';
import 'package:media_vault/features/albums/presentation/widgets/trash_appbar_icon.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/routes/routes.gr.dart';
import 'package:media_vault/shared/widgets/custom_input_alert_dialog.dart';
import 'package:media_vault/shared/widgets/loading_indicator.dart';

import '../../../injection.dart';

@RoutePage()
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
            icon: const Icon(Icons.person),
            onPressed: () {
              AutoRouter.of(context).push(ProfileRoute());
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
                        : const Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
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
