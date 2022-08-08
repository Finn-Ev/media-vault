// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i16;
import 'package:flutter/material.dart' as _i17;

import '../../domain/entities/media/album.dart' as _i18;
import '../../domain/entities/media/asset.dart' as _i19;
import '../auth/local_auth/enter_local_auth/enter_local_auth_page.dart' as _i7;
import '../auth/local_auth/forgot_pin/forgot_pin_page.dart' as _i9;
import '../auth/local_auth/local_auth_root_page.dart' as _i6;
import '../auth/local_auth/setup_local_auth/setup_local_auth_page.dart' as _i8;
import '../auth/remote_auth/forgot_password/forgot_password_page.dart' as _i5;
import '../auth/remote_auth/login/login_page.dart' as _i3;
import '../auth/remote_auth/register/register_page.dart' as _i4;
import '../media/album_list/album_list_page.dart' as _i10;
import '../media/asset_carousel/asset_carousel_page.dart' as _i12;
import '../media/asset_list/asset_list_page.dart' as _i11;
import '../media/asset_list/trash/trash_page.dart' as _i15;
import '../media/asset_video_player/asset_video_player_page.dart' as _i13;
import '../media/move_assets/move_assets_page.dart' as _i14;
import '../other/settings/settings_page.dart' as _i2;
import '../other/splash/splash_page.dart' as _i1;

class AppRouter extends _i16.RootStackRouter {
  AppRouter([_i17.GlobalKey<_i17.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i16.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    SettingsRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SettingsPage());
    },
    LoginRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginPage());
    },
    RegisterRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegisterPage());
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ForgotPasswordPage());
    },
    LocalAuthRootRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i6.LocalAuthRootPage());
    },
    EnterLocalAuthRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i7.EnterLocalAuthPage());
    },
    SetupLocalAuthRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.SetupLocalAuthPage());
    },
    ForgotPinRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i9.ForgotPinPage());
    },
    AlbumListRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i10.AlbumListPage(),
          maintainState: false);
    },
    AssetListRoute.name: (routeData) {
      final args = routeData.argsAs<AssetListRouteArgs>();
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i11.AssetListPage(album: args.album, key: args.key),
          maintainState: false);
    },
    AssetCarouselRoute.name: (routeData) {
      final args = routeData.argsAs<AssetCarouselRouteArgs>();
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i12.AssetCarouselPage(
              albumId: args.albumId,
              initialIndex: args.initialIndex,
              key: args.key));
    },
    AssetVideoPlayerRoute.name: (routeData) {
      final args = routeData.argsAs<AssetVideoPlayerRouteArgs>();
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.AssetVideoPlayerPage(url: args.url, key: args.key),
          fullscreenDialog: true);
    },
    MoveAssetsRoute.name: (routeData) {
      final args = routeData.argsAs<MoveAssetsRouteArgs>();
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i14.MoveAssetsPage(
              sourceAlbumId: args.sourceAlbumId,
              assets: args.assets,
              copy: args.copy,
              key: args.key),
          fullscreenDialog: true);
    },
    TrashRoute.name: (routeData) {
      return _i16.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i15.TrashPage(),
          maintainState: false);
    }
  };

  @override
  List<_i16.RouteConfig> get routes => [
        _i16.RouteConfig(SplashRoute.name, path: '/'),
        _i16.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i16.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i16.RouteConfig(RegisterRoute.name, path: '/register-page'),
        _i16.RouteConfig(ForgotPasswordRoute.name,
            path: '/forgot-password-page'),
        _i16.RouteConfig(LocalAuthRootRoute.name,
            path: '/local-auth-root-page'),
        _i16.RouteConfig(EnterLocalAuthRoute.name,
            path: '/enter-local-auth-page'),
        _i16.RouteConfig(SetupLocalAuthRoute.name,
            path: '/setup-local-auth-page'),
        _i16.RouteConfig(ForgotPinRoute.name, path: '/forgot-pin-page'),
        _i16.RouteConfig(AlbumListRoute.name, path: '/album-list-page'),
        _i16.RouteConfig(AssetListRoute.name, path: '/asset-list-page'),
        _i16.RouteConfig(AssetCarouselRoute.name, path: '/asset-carousel-page'),
        _i16.RouteConfig(AssetVideoPlayerRoute.name,
            path: '/asset-video-player-page'),
        _i16.RouteConfig(MoveAssetsRoute.name, path: '/move-assets-page'),
        _i16.RouteConfig(TrashRoute.name, path: '/trash-page')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i16.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SettingsPage]
class SettingsRoute extends _i16.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i16.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i16.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: '/register-page');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.ForgotPasswordPage]
class ForgotPasswordRoute extends _i16.PageRouteInfo<void> {
  const ForgotPasswordRoute()
      : super(ForgotPasswordRoute.name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i6.LocalAuthRootPage]
class LocalAuthRootRoute extends _i16.PageRouteInfo<void> {
  const LocalAuthRootRoute()
      : super(LocalAuthRootRoute.name, path: '/local-auth-root-page');

  static const String name = 'LocalAuthRootRoute';
}

/// generated route for
/// [_i7.EnterLocalAuthPage]
class EnterLocalAuthRoute extends _i16.PageRouteInfo<void> {
  const EnterLocalAuthRoute()
      : super(EnterLocalAuthRoute.name, path: '/enter-local-auth-page');

  static const String name = 'EnterLocalAuthRoute';
}

/// generated route for
/// [_i8.SetupLocalAuthPage]
class SetupLocalAuthRoute extends _i16.PageRouteInfo<void> {
  const SetupLocalAuthRoute()
      : super(SetupLocalAuthRoute.name, path: '/setup-local-auth-page');

  static const String name = 'SetupLocalAuthRoute';
}

/// generated route for
/// [_i9.ForgotPinPage]
class ForgotPinRoute extends _i16.PageRouteInfo<void> {
  const ForgotPinRoute() : super(ForgotPinRoute.name, path: '/forgot-pin-page');

  static const String name = 'ForgotPinRoute';
}

/// generated route for
/// [_i10.AlbumListPage]
class AlbumListRoute extends _i16.PageRouteInfo<void> {
  const AlbumListRoute() : super(AlbumListRoute.name, path: '/album-list-page');

  static const String name = 'AlbumListRoute';
}

/// generated route for
/// [_i11.AssetListPage]
class AssetListRoute extends _i16.PageRouteInfo<AssetListRouteArgs> {
  AssetListRoute({required _i18.Album album, _i17.Key? key})
      : super(AssetListRoute.name,
            path: '/asset-list-page',
            args: AssetListRouteArgs(album: album, key: key));

  static const String name = 'AssetListRoute';
}

class AssetListRouteArgs {
  const AssetListRouteArgs({required this.album, this.key});

  final _i18.Album album;

  final _i17.Key? key;

  @override
  String toString() {
    return 'AssetListRouteArgs{album: $album, key: $key}';
  }
}

/// generated route for
/// [_i12.AssetCarouselPage]
class AssetCarouselRoute extends _i16.PageRouteInfo<AssetCarouselRouteArgs> {
  AssetCarouselRoute(
      {required String albumId, required int initialIndex, _i17.Key? key})
      : super(AssetCarouselRoute.name,
            path: '/asset-carousel-page',
            args: AssetCarouselRouteArgs(
                albumId: albumId, initialIndex: initialIndex, key: key));

  static const String name = 'AssetCarouselRoute';
}

class AssetCarouselRouteArgs {
  const AssetCarouselRouteArgs(
      {required this.albumId, required this.initialIndex, this.key});

  final String albumId;

  final int initialIndex;

  final _i17.Key? key;

  @override
  String toString() {
    return 'AssetCarouselRouteArgs{albumId: $albumId, initialIndex: $initialIndex, key: $key}';
  }
}

/// generated route for
/// [_i13.AssetVideoPlayerPage]
class AssetVideoPlayerRoute
    extends _i16.PageRouteInfo<AssetVideoPlayerRouteArgs> {
  AssetVideoPlayerRoute({required String url, _i17.Key? key})
      : super(AssetVideoPlayerRoute.name,
            path: '/asset-video-player-page',
            args: AssetVideoPlayerRouteArgs(url: url, key: key));

  static const String name = 'AssetVideoPlayerRoute';
}

class AssetVideoPlayerRouteArgs {
  const AssetVideoPlayerRouteArgs({required this.url, this.key});

  final String url;

  final _i17.Key? key;

  @override
  String toString() {
    return 'AssetVideoPlayerRouteArgs{url: $url, key: $key}';
  }
}

/// generated route for
/// [_i14.MoveAssetsPage]
class MoveAssetsRoute extends _i16.PageRouteInfo<MoveAssetsRouteArgs> {
  MoveAssetsRoute(
      {required String sourceAlbumId,
      required List<_i19.Asset> assets,
      required bool copy,
      _i17.Key? key})
      : super(MoveAssetsRoute.name,
            path: '/move-assets-page',
            args: MoveAssetsRouteArgs(
                sourceAlbumId: sourceAlbumId,
                assets: assets,
                copy: copy,
                key: key));

  static const String name = 'MoveAssetsRoute';
}

class MoveAssetsRouteArgs {
  const MoveAssetsRouteArgs(
      {required this.sourceAlbumId,
      required this.assets,
      required this.copy,
      this.key});

  final String sourceAlbumId;

  final List<_i19.Asset> assets;

  final bool copy;

  final _i17.Key? key;

  @override
  String toString() {
    return 'MoveAssetsRouteArgs{sourceAlbumId: $sourceAlbumId, assets: $assets, copy: $copy, key: $key}';
  }
}

/// generated route for
/// [_i15.TrashPage]
class TrashRoute extends _i16.PageRouteInfo<void> {
  const TrashRoute() : super(TrashRoute.name, path: '/trash-page');

  static const String name = 'TrashRoute';
}
