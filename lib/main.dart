import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:media_vault/application/albums/controller/album_controller_bloc.dart';
import 'package:media_vault/application/assets/asset_list/asset_list_bloc.dart';
import 'package:media_vault/application/assets/controller/asset_controller_bloc.dart';
import 'package:media_vault/application/auth/local_auth/local_auth_bloc.dart';
import 'package:media_vault/application/auth/remote_auth/remote_auth_core/remote_auth_core_bloc.dart';
import 'package:media_vault/firebase_options.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart' as router;
import 'package:media_vault/theme.dart';

import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  // try {
  runApp(MyApp());
  // }
  // on NotAuthenticatedError {
  //   router.AppRouter().replace(const router.LoginPageRoute());
  // }
}

class MyApp extends StatelessWidget {
  final _appRouter = router.AppRouter();

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCoreBloc>(create: (context) => sl<AuthCoreBloc>()..add(AuthCheckRequested())),
        BlocProvider<LocalAuthBloc>(create: (context) => sl<LocalAuthBloc>()),
        BlocProvider<AlbumControllerBloc>(create: (context) => sl<AlbumControllerBloc>()),
        BlocProvider<AssetControllerBloc>(create: (context) => sl<AssetControllerBloc>()),
        BlocProvider<AssetListBloc>(create: (context) => sl<AssetListBloc>()),
      ],
      child: MaterialApp.router(
        routeInformationParser: _appRouter.defaultRouteParser(),
        routerDelegate: _appRouter.delegate(),
        title: 'Media-Vault',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
      ),
    );
  }
}
