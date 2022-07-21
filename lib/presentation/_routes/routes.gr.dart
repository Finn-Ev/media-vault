// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../../domain/entities/media/album.dart' as _i11;
import '../auth/forgot_password/forgot_password_page.dart' as _i5;
import '../auth/login/login_page.dart' as _i3;
import '../auth/register/register_page.dart' as _i4;
import '../media/album_list/album_list_page.dart' as _i6;
import '../media/asset_carousel/asset_carousel_page.dart' as _i8;
import '../media/asset_list/asset_list_page.dart' as _i7;
import '../other/settings/settings_page.dart' as _i2;
import '../other/splash/splash_page.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SplashPage());
    },
    SettingsPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.SettingsPage());
    },
    LoginPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.LoginPage());
    },
    RegisterPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegisterPage());
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i5.ForgotPasswordPage());
    },
    AlbumListPageRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i6.AlbumListPage(),
          maintainState: false);
    },
    AssetListPageRoute.name: (routeData) {
      final args = routeData.argsAs<AssetListPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.AssetListPage(album: args.album, key: args.key));
    },
    AssetCarouselPageRoute.name: (routeData) {
      final args = routeData.argsAs<AssetCarouselPageRouteArgs>();
      return _i9.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i8.AssetCarouselPage(
              albumId: args.albumId,
              initialAssetId: args.initialAssetId,
              key: args.key),
          fullscreenDialog: true);
    }
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(SplashPageRoute.name, path: '/'),
        _i9.RouteConfig(SettingsPageRoute.name, path: '/settings-page'),
        _i9.RouteConfig(LoginPageRoute.name, path: '/login-page'),
        _i9.RouteConfig(RegisterPageRoute.name, path: '/register-page'),
        _i9.RouteConfig(ForgotPasswordPageRoute.name,
            path: '/forgot-password-page'),
        _i9.RouteConfig(AlbumListPageRoute.name, path: '/album-list-page'),
        _i9.RouteConfig(AssetListPageRoute.name, path: '/asset-list-page'),
        _i9.RouteConfig(AssetCarouselPageRoute.name,
            path: '/asset-carousel-page')
      ];
}

/// generated route for
/// [_i1.SplashPage]
class SplashPageRoute extends _i9.PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [_i2.SettingsPage]
class SettingsPageRoute extends _i9.PageRouteInfo<void> {
  const SettingsPageRoute()
      : super(SettingsPageRoute.name, path: '/settings-page');

  static const String name = 'SettingsPageRoute';
}

/// generated route for
/// [_i3.LoginPage]
class LoginPageRoute extends _i9.PageRouteInfo<void> {
  const LoginPageRoute() : super(LoginPageRoute.name, path: '/login-page');

  static const String name = 'LoginPageRoute';
}

/// generated route for
/// [_i4.RegisterPage]
class RegisterPageRoute extends _i9.PageRouteInfo<void> {
  const RegisterPageRoute()
      : super(RegisterPageRoute.name, path: '/register-page');

  static const String name = 'RegisterPageRoute';
}

/// generated route for
/// [_i5.ForgotPasswordPage]
class ForgotPasswordPageRoute extends _i9.PageRouteInfo<void> {
  const ForgotPasswordPageRoute()
      : super(ForgotPasswordPageRoute.name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordPageRoute';
}

/// generated route for
/// [_i6.AlbumListPage]
class AlbumListPageRoute extends _i9.PageRouteInfo<void> {
  const AlbumListPageRoute()
      : super(AlbumListPageRoute.name, path: '/album-list-page');

  static const String name = 'AlbumListPageRoute';
}

/// generated route for
/// [_i7.AssetListPage]
class AssetListPageRoute extends _i9.PageRouteInfo<AssetListPageRouteArgs> {
  AssetListPageRoute({required _i11.Album album, _i10.Key? key})
      : super(AssetListPageRoute.name,
            path: '/asset-list-page',
            args: AssetListPageRouteArgs(album: album, key: key));

  static const String name = 'AssetListPageRoute';
}

class AssetListPageRouteArgs {
  const AssetListPageRouteArgs({required this.album, this.key});

  final _i11.Album album;

  final _i10.Key? key;

  @override
  String toString() {
    return 'AssetListPageRouteArgs{album: $album, key: $key}';
  }
}

/// generated route for
/// [_i8.AssetCarouselPage]
class AssetCarouselPageRoute
    extends _i9.PageRouteInfo<AssetCarouselPageRouteArgs> {
  AssetCarouselPageRoute(
      {required String albumId, required String initialAssetId, _i10.Key? key})
      : super(AssetCarouselPageRoute.name,
            path: '/asset-carousel-page',
            args: AssetCarouselPageRouteArgs(
                albumId: albumId, initialAssetId: initialAssetId, key: key));

  static const String name = 'AssetCarouselPageRoute';
}

class AssetCarouselPageRouteArgs {
  const AssetCarouselPageRouteArgs(
      {required this.albumId, required this.initialAssetId, this.key});

  final String albumId;

  final String initialAssetId;

  final _i10.Key? key;

  @override
  String toString() {
    return 'AssetCarouselPageRouteArgs{albumId: $albumId, initialAssetId: $initialAssetId, key: $key}';
  }
}
