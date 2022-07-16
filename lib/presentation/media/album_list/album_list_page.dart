import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/observer/album_observer_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
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
              icon: const Icon(Icons.logout),
              onPressed: () {
                BlocProvider.of<AuthCoreBloc>(context).add(SignOutButtonPressed());
              },
            ),
            title: Text('My Albums'),
          ),
          body: AlbumList(),
        ),
      ),
    );
  }
}
