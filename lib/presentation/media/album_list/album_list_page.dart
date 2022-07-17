import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/controller/album_controller_bloc.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/input_alert.dart';
import 'package:media_vault/presentation/media/album_list/widgets/album_list_widget.dart';

import '../../../injection.dart';

class AlbumListPage extends StatelessWidget {
  const AlbumListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final albumObserverBloc = sl<AlbumObserverBloc>()..add(AlbumsObserveAll());

    return MultiBlocProvider(
      providers: [
        BlocProvider<AlbumObserverBloc>(
          create: (context) => albumObserverBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCoreBloc, AuthCoreState>(listener: (context, state) {
            if (state is AuthCoreUnauthenticated) {
              AutoRouter.of(context).replace(const LoginPageRoute());
            }
          }),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                BlocProvider.of<AuthCoreBloc>(context).add(SignOutButtonPressed());
                // AutoRouter.of(context).push(const SettingsPageRoute());
              },
            ),
            title: const Text('My Albums'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) {
                      return InputAlert(
                        title: 'Create Album',
                        hintText: 'Enter the name of the album',
                        onSubmit: (value) {
                          BlocProvider.of<AlbumControllerBloc>(context).add(CreateAlbum(title: value));
                        },
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: const AlbumList(),
        ),
      ),
    );
  }
}
