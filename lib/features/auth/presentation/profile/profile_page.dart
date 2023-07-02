import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/features/albums/application/controller/album_controller_bloc.dart';
import 'package:media_vault/features/albums/application/observer/album_observer_bloc.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/injection.dart';
import 'package:media_vault/routes/routes.gr.dart';
import 'package:media_vault/shared/widgets/custom_alert_dialog.dart';
import 'package:media_vault/shared/widgets/custom_button.dart';
import 'package:media_vault/shared/widgets/horizontal_text_divider.dart';

@RoutePage()
class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final albumObserverBloc = sl<AlbumObserverBloc>()..add(AlbumsObserveAll());

  @override
  Widget build(BuildContext context) {
    openLogoutAlert() {
      showPlatformDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: "Logout?",
          content: "Do you really want to logout of Media-Vault?",
          confirmIsDestructive: true,
          onConfirm: () {
            BlocProvider.of<AuthCoreBloc>(context).add(LogoutRequested());
          },
        ),
      );
    }

    openDeleteEverythingAlert() {
      showPlatformDialog(
        context: context,
        builder: (_) => CustomAlertDialog(
          title: "Delete everything?",
          content: "Do you really want to delete all your uploaded albums and assets?",
          confirmIsDestructive: true,
          onConfirm: () {
            BlocProvider.of<AlbumControllerBloc>(context).add(DeleteAllAlbums());
            Navigator.of(context).pop();
          },
        ),
      );
    }

    return BlocProvider(
      create: (context) => albumObserverBloc,
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCoreBloc, AuthCoreState>(
            listener: (context, state) {
              if (state is AuthCoreUnauthenticated) {
                AutoRouter.of(context).replace(const LoginRoute());
              }
            },
          ),
          BlocListener<AlbumControllerBloc, AlbumControllerState>(
            listener: (context, state) {
              if (state is AlbumControllerLoaded) {
                //  show success alert
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    backgroundColor: Colors.green[800],
                    content: const Text(
                      'Your albums and assets have been deleted.',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text('My Profile'),
          ),
          body: Column(
            children: [
              const Text("Logged in as"),
              const SizedBox(height: 5),
              Text((BlocProvider.of<AuthCoreBloc>(context).state as AuthCoreAuthenticated).user.email),
              const SizedBox(height: 20),
              CustomButton(
                text: "Change PIN",
                onPressed: () => AutoRouter.of(context).push(const EditPinRoute()),
              ),
              const SizedBox(height: 20),
              CustomButton(
                text: "Logout from Media-Vault",
                onPressed: openLogoutAlert,
              ),
              Expanded(
                child: BlocBuilder<AlbumObserverBloc, AlbumObserverState>(
                  builder: (context, state) {
                    if (state is AlbumObserverInitial) {
                      return Container();
                    } else if (state is AlbumObserverFailure) {
                      return const Center(child: Text('Failed to load albums'));
                    } else if (state is AlbumObserverLoaded && state.albums.isNotEmpty) {
                      return Column(
                        children: [
                          const SizedBox(height: 10),
                          const HorizontalTextDivider(''),
                          const SizedBox(height: 10),
                          CustomButton(
                              text: "Delete my albums and assets",
                              onPressed: openDeleteEverythingAlert,
                              isVeryDestructive: true),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
