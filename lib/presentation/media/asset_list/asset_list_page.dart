import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/assets/observer/asset_observer_bloc.dart';
import 'package:media_vault/application/auth/auth_core/auth_core_bloc.dart';
import 'package:media_vault/domain/entities/media/album.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/loading_indicator.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_app_bar_actions.dart';
import 'package:media_vault/presentation/media/asset_list/widgets/asset_list_widget.dart';

import '../../../injection.dart';

class AssetListPage extends StatelessWidget {
  final Album album;
  const AssetListPage({required this.album, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final assetObserverBloc = sl<AssetObserverBloc>()..add(ObserveAlbumAssets(albumId: album.id.value));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AssetObserverBloc>(
          create: (context) => assetObserverBloc,
        ),
        BlocProvider<AssetListBloc>(create: (context) => sl<AssetListBloc>())
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCoreBloc, AuthCoreState>(
            listener: (context, state) {
              if (state is AuthCoreUnauthenticated) {
                AutoRouter.of(context).replace(const LoginPageRoute());
              }
            },
          ),
        ],
        child: BlocBuilder<AssetControllerBloc, AssetControllerState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(album.title),
                actions: [
                  if (state is AssetControllerInitial || state is AssetControllerLoaded) AssetListAppBarActions(albumId: album.id) else Container(),
                ],
              ),
              body: (state is AssetControllerLoading
                  ? Center(
                      child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const LoadingIndicator(),
                        const SizedBox(height: 10),
                        state.currentStep >= 0 ? Text('Uploading asset: ${state.currentStep}/${state.totalSteps}') : Container(),
                      ],
                    ))
                  : AssetList(albumId: album.id.toString())),
            );
          },
        ),
      ),
    );
  }
}
