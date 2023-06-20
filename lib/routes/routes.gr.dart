// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;

import '../domain/entities/media/album.dart' as _i20;
import '../domain/entities/media/asset.dart' as _i21;
import '../presentation/auth/local_auth/edit_pin/edit_pin_page.dart' as _i10;
import '../presentation/auth/local_auth/enter_local_auth/enter_local_auth_page.dart' as _i7;
import '../presentation/auth/local_auth/forgot_pin/forgot_pin_page.dart' as _i11;
import '../presentation/auth/local_auth/local_auth_root_page.dart' as _i6;
import '../presentation/auth/local_auth/local_auth_setup/confirm_local_auth_setup_page.dart' as _i9;
import '../presentation/auth/local_auth/local_auth_setup/local_auth_setup_page.dart' as _i8;
import '../presentation/auth/remote_auth/forgot_password/forgot_password_page.dart' as _i5;
import '../presentation/auth/remote_auth/login/login_page.dart' as _i3;
import '../presentation/auth/remote_auth/register/register_page.dart' as _i4;
import '../presentation/media/album_list/album_list_page.dart' as _i12;
import '../presentation/media/asset_carousel/asset_carousel_page.dart' as _i14;
import '../presentation/media/asset_list/asset_list_page.dart' as _i13;
import '../presentation/media/asset_list/trash/trash_page.dart' as _i17;
import '../presentation/media/asset_video_player/asset_video_player_page.dart' as _i15;
import '../presentation/media/move_assets/move_assets_page.dart' as _i16;
import '../presentation/other/settings/settings_page.dart' as _i2;
import '../presentation/other/splash/splash_page.dart' as _i1;

class AppRouter extends _i18.RootStackRouter {
  AppRouter([_i19.GlobalKey<_i19.NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    SplashRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i1.SplashPage());
    },
    SettingsRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i2.SettingsPage());
    },
    LoginRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i3.LoginPage());
    },
    RegisterRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i4.RegisterPage());
    },
    ForgotPasswordRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i5.ForgotPasswordPage());
    },
    LocalAuthRootRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i6.LocalAuthRootPage());
    },
    EnterLocalAuthRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i7.EnterLocalAuthPage());
    },
    LocalAuthSetupRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i8.LocalAuthSetupPage());
    },
    ConfirmLocalAuthSetupRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmLocalAuthSetupRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: _i9.ConfirmLocalAuthSetupPage(pin: args.pin, key: args.key));
    },
    EditPinRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i10.EditPinPage(), maintainState: false);
    },
    ForgotPinRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(routeData: routeData, child: const _i11.ForgotPinPage());
    },
    AlbumListRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.AlbumListPage(), maintainState: false);
    },
    AssetListRoute.name: (routeData) {
      final args = routeData.argsAs<AssetListRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i13.AssetListPage(album: args.album, key: args.key),
          maintainState: false);
    },
    AssetCarouselRoute.name: (routeData) {
      final args = routeData.argsAs<AssetCarouselRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              _i14.AssetCarouselPage(albumId: args.albumId, initialIndex: args.initialIndex, key: args.key));
    },
    AssetVideoPlayerRoute.name: (routeData) {
      final args = routeData.argsAs<AssetVideoPlayerRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i15.AssetVideoPlayerPage(url: args.url, key: args.key),
          fullscreenDialog: true);
    },
    MoveAssetsRoute.name: (routeData) {
      final args = routeData.argsAs<MoveAssetsRouteArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i16.MoveAssetsPage(
              sourceAlbumId: args.sourceAlbumId, assets: args.assets, copy: args.copy, key: args.key),
          fullscreenDialog: true);
    },
    TrashRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.TrashPage(), maintainState: false);
    }
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig(SplashRoute.name, path: '/'),
        _i18.RouteConfig(SettingsRoute.name, path: '/settings-page'),
        _i18.RouteConfig(LoginRoute.name, path: '/login-page'),
        _i18.RouteConfig(RegisterRoute.name, path: '/register-page'),
        _i18.RouteConfig(ForgotPasswordRoute.name, path: '/forgot-password-page'),
        _i18.RouteConfig(LocalAuthRootRoute.name, path: '/local-auth-root-page'),
        _i18.RouteConfig(EnterLocalAuthRoute.name, path: '/enter-local-auth-page'),
        _i18.RouteConfig(LocalAuthSetupRoute.name, path: '/local-auth-setup-page'),
        _i18.RouteConfig(ConfirmLocalAuthSetupRoute.name, path: '/confirm-local-auth-setup-page'),
        _i18.RouteConfig(EditPinRoute.name, path: '/edit-pin-page'),
        _i18.RouteConfig(ForgotPinRoute.name, path: '/forgot-pin-page'),
        _i18.RouteConfig(AlbumListRoute.name, path: '/album-list-page'),
        _i18.RouteConfig(AssetListRoute.name, path: '/asset-list-page'),
        _i18.RouteConfig(AssetCarouselRoute.name, path: '/asset-carousel-page'),
        _i18.RouteConfig(AssetVideoPlayerRoute.name, path: '/asset-video-player-page'),
        _i18.RouteConfig(MoveAssetsRoute.name, path: '/move-assets-page'),
        _i18.RouteConfig(TrashRoute.name, path: '/trash-page')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashRoute extends _i18.PageRouteInfo<void> {
  const SplashRoute() : super(SplashRoute.name, path: '/');

  static const String name = 'SplashRoute';
}

/// generated route for
/// [_i2.SettingsPage]
class SettingsRoute extends _i18.PageRouteInfo<void> {
  const SettingsRoute() : super(SettingsRoute.name, path: '/settings-page');

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute() : super(LoginRoute.name, path: '/login-page');

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterRoute extends _i18.PageRouteInfo<void> {
  const RegisterRoute() : super(RegisterRoute.name, path: '/register-page');

  static const String name = 'RegisterRoute';
}

/// generated route for
/// [_i5.ForgotPasswordPage]
class ForgotPasswordRoute extends _i18.PageRouteInfo<void> {
  const ForgotPasswordRoute() : super(ForgotPasswordRoute.name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordRoute';
}

/// generated route for
/// [_i6.LocalAuthRootPage]
class LocalAuthRootRoute extends _i18.PageRouteInfo<void> {
  const LocalAuthRootRoute() : super(LocalAuthRootRoute.name, path: '/local-auth-root-page');

  static const String name = 'LocalAuthRootRoute';
}

/// generated route for
/// [_i7.EnterLocalAuthPage]
class EnterLocalAuthRoute extends _i18.PageRouteInfo<void> {
  const EnterLocalAuthRoute() : super(EnterLocalAuthRoute.name, path: '/enter-local-auth-page');

  static const String name = 'EnterLocalAuthRoute';
}

/// generated route for
/// [_i8.LocalAuthSetupPage]
class LocalAuthSetupRoute extends _i18.PageRouteInfo<void> {
  const LocalAuthSetupRoute() : super(LocalAuthSetupRoute.name, path: '/local-auth-setup-page');

  static const String name = 'LocalAuthSetupRoute';
}

/// generated route for
/// [_i9.ConfirmLocalAuthSetupPage]
class ConfirmLocalAuthSetupRoute extends _i18.PageRouteInfo<ConfirmLocalAuthSetupRouteArgs> {
  ConfirmLocalAuthSetupRoute({required String pin, _i19.Key? key})
      : super(ConfirmLocalAuthSetupRoute.name,
            path: '/confirm-local-auth-setup-page', args: ConfirmLocalAuthSetupRouteArgs(pin: pin, key: key));

  static const String name = 'ConfirmLocalAuthSetupRoute';
}

class ConfirmLocalAuthSetupRouteArgs {
  const ConfirmLocalAuthSetupRouteArgs({required this.pin, this.key});

  final String pin;

  final _i19.Key? key;

  @override
  String toString() {
    return 'ConfirmLocalAuthSetupRouteArgs{pin: $pin, key: $key}';
  }
}

/// generated route for
/// [_i10.EditPinPage]
class EditPinRoute extends _i18.PageRouteInfo<void> {
  const EditPinRoute() : super(EditPinRoute.name, path: '/edit-pin-page');

  static const String name = 'EditPinRoute';
}

/// generated route for
/// [_i11.ForgotPinPage]
class ForgotPinRoute extends _i18.PageRouteInfo<void> {
  const ForgotPinRoute() : super(ForgotPinRoute.name, path: '/forgot-pin-page');

  static const String name = 'ForgotPinRoute';
}

/// generated route for
/// [_i12.AlbumListPage]
class AlbumListRoute extends _i18.PageRouteInfo<void> {
  const AlbumListRoute() : super(AlbumListRoute.name, path: '/album-list-page');

  static const String name = 'AlbumListRoute';
}

/// generated route for
/// [_i13.AssetListPage]
class AssetListRoute extends _i18.PageRouteInfo<AssetListRouteArgs> {
  AssetListRoute({required _i20.Album album, _i19.Key? key})
      : super(AssetListRoute.name,
            path: '/asset-list-page', args: AssetListRouteArgs(album: album, key: key));

  static const String name = 'AssetListRoute';
}

class AssetListRouteArgs {
  const AssetListRouteArgs({required this.album, this.key});

  final _i20.Album album;

  final _i19.Key? key;

  @override
  String toString() {
    return 'AssetListRouteArgs{album: $album, key: $key}';
  }
}

/// generated route for
/// [_i14.AssetCarouselPage]
class AssetCarouselRoute extends _i18.PageRouteInfo<AssetCarouselRouteArgs> {
  AssetCarouselRoute({required String albumId, required int initialIndex, _i19.Key? key})
      : super(AssetCarouselRoute.name,
            path: '/asset-carousel-page',
            args: AssetCarouselRouteArgs(albumId: albumId, initialIndex: initialIndex, key: key));

  static const String name = 'AssetCarouselRoute';
}

class AssetCarouselRouteArgs {
  const AssetCarouselRouteArgs({required this.albumId, required this.initialIndex, this.key});

  final String albumId;

  final int initialIndex;

  final _i19.Key? key;

  @override
  String toString() {
    return 'AssetCarouselRouteArgs{albumId: $albumId, initialIndex: $initialIndex, key: $key}';
  }
}

/// generated route for
/// [_i15.AssetVideoPlayerPage]
class AssetVideoPlayerRoute extends _i18.PageRouteInfo<AssetVideoPlayerRouteArgs> {
  AssetVideoPlayerRoute({required String url, _i19.Key? key})
      : super(AssetVideoPlayerRoute.name,
            path: '/asset-video-player-page', args: AssetVideoPlayerRouteArgs(url: url, key: key));

  static const String name = 'AssetVideoPlayerRoute';
}

class AssetVideoPlayerRouteArgs {
  const AssetVideoPlayerRouteArgs({required this.url, this.key});

  final String url;

  final _i19.Key? key;

  @override
  String toString() {
    return 'AssetVideoPlayerRouteArgs{url: $url, key: $key}';
  }
}

/// generated route for
/// [_i16.MoveAssetsPage]
class MoveAssetsRoute extends _i18.PageRouteInfo<MoveAssetsRouteArgs> {
  MoveAssetsRoute(
      {required String sourceAlbumId, required List<_i21.Asset> assets, required bool copy, _i19.Key? key})
      : super(MoveAssetsRoute.name,
            path: '/move-assets-page',
            args: MoveAssetsRouteArgs(sourceAlbumId: sourceAlbumId, assets: assets, copy: copy, key: key));

  static const String name = 'MoveAssetsRoute';
}

class MoveAssetsRouteArgs {
  const MoveAssetsRouteArgs(
      {required this.sourceAlbumId, required this.assets, required this.copy, this.key});

  final String sourceAlbumId;

  final List<_i21.Asset> assets;

  final bool copy;

  final _i19.Key? key;

  @override
  String toString() {
    return 'MoveAssetsRouteArgs{sourceAlbumId: $sourceAlbumId, assets: $assets, copy: $copy, key: $key}';
  }
}

/// generated route for
/// [_i17.TrashPage]
class TrashRoute extends _i18.PageRouteInfo<void> {
  const TrashRoute() : super(TrashRoute.name, path: '/trash-page');

  static const String name = 'TrashRoute';
}
