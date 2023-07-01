// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/foundation.dart' as _i21;
import 'package:flutter/material.dart' as _i19;
import 'package:media_vault/features/albums/domain/entities/album.dart' as _i20;
import 'package:media_vault/features/albums/presentation/album_list_page.dart'
    as _i16;
import 'package:media_vault/features/assets/domain/entities/asset.dart' as _i22;
import 'package:media_vault/features/assets/presentation/asset_carousel/asset_carousel_page.dart'
    as _i11;
import 'package:media_vault/features/assets/presentation/asset_list/asset_list_page.dart'
    as _i13;
import 'package:media_vault/features/assets/presentation/asset_list/trash/trash_page.dart'
    as _i12;
import 'package:media_vault/features/assets/presentation/asset_video_player/asset_video_player_page.dart'
    as _i14;
import 'package:media_vault/features/assets/presentation/move_assets/move_assets_page.dart'
    as _i15;
import 'package:media_vault/features/auth/presentation/local_auth/edit_pin/edit_pin_page.dart'
    as _i6;
import 'package:media_vault/features/auth/presentation/local_auth/enter_local_auth/enter_local_auth_page.dart'
    as _i8;
import 'package:media_vault/features/auth/presentation/local_auth/forgot_pin/forgot_pin_page.dart'
    as _i7;
import 'package:media_vault/features/auth/presentation/local_auth/local_auth_root_page.dart'
    as _i9;
import 'package:media_vault/features/auth/presentation/local_auth/local_auth_setup/confirm_local_auth_setup_page.dart'
    as _i5;
import 'package:media_vault/features/auth/presentation/local_auth/local_auth_setup/local_auth_setup_page.dart'
    as _i4;
import 'package:media_vault/features/auth/presentation/profile/profile_page.dart'
    as _i17;
import 'package:media_vault/features/auth/presentation/remote_auth/forgot_password/forgot_password_page.dart'
    as _i1;
import 'package:media_vault/features/auth/presentation/remote_auth/login/login_page.dart'
    as _i3;
import 'package:media_vault/features/auth/presentation/remote_auth/register/register_page.dart'
    as _i2;
import 'package:media_vault/features/auth/presentation/splash_page.dart'
    as _i10;

abstract class $AppRouter extends _i18.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    ForgotPasswordRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ForgotPasswordPage(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.RegisterPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.LoginPage(),
      );
    },
    LocalAuthSetupRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.LocalAuthSetupPage(),
      );
    },
    ConfirmLocalAuthSetupRoute.name: (routeData) {
      final args = routeData.argsAs<ConfirmLocalAuthSetupRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.ConfirmLocalAuthSetupPage(
          pin: args.pin,
          key: args.key,
        ),
      );
    },
    EditPinRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.EditPinPage(),
      );
    },
    ForgotPinRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.ForgotPinPage(),
      );
    },
    EnterLocalAuthRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.EnterLocalAuthPage(),
      );
    },
    LocalAuthRootRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.LocalAuthRootPage(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SplashPage(),
      );
    },
    AssetCarouselRoute.name: (routeData) {
      final args = routeData.argsAs<AssetCarouselRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.AssetCarouselPage(
          albumId: args.albumId,
          initialIndex: args.initialIndex,
          key: args.key,
        ),
      );
    },
    TrashRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.TrashPage(),
      );
    },
    AssetListRoute.name: (routeData) {
      final args = routeData.argsAs<AssetListRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.AssetListPage(
          album: args.album,
          key: args.key,
        ),
      );
    },
    AssetVideoPlayerRoute.name: (routeData) {
      final args = routeData.argsAs<AssetVideoPlayerRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i14.AssetVideoPlayerPage(
          url: args.url,
          key: args.key,
        ),
      );
    },
    MoveAssetsRoute.name: (routeData) {
      final args = routeData.argsAs<MoveAssetsRouteArgs>();
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.MoveAssetsPage(
          sourceAlbumId: args.sourceAlbumId,
          assets: args.assets,
          copy: args.copy,
          key: args.key,
        ),
      );
    },
    AlbumListRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.AlbumListPage(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i18.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i17.ProfilePage(),
      );
    },
  };
}

/// generated route for
/// [_i1.ForgotPasswordPage]
class ForgotPasswordRoute extends _i18.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ForgotPasswordRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPasswordRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i2.RegisterPage]
class RegisterRoute extends _i18.PageRouteInfo<void> {
  const RegisterRoute({List<_i18.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i3.LoginPage]
class LoginRoute extends _i18.PageRouteInfo<void> {
  const LoginRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LocalAuthSetupPage]
class LocalAuthSetupRoute extends _i18.PageRouteInfo<void> {
  const LocalAuthSetupRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LocalAuthSetupRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocalAuthSetupRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i5.ConfirmLocalAuthSetupPage]
class ConfirmLocalAuthSetupRoute
    extends _i18.PageRouteInfo<ConfirmLocalAuthSetupRouteArgs> {
  ConfirmLocalAuthSetupRoute({
    required String pin,
    _i19.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          ConfirmLocalAuthSetupRoute.name,
          args: ConfirmLocalAuthSetupRouteArgs(
            pin: pin,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ConfirmLocalAuthSetupRoute';

  static const _i18.PageInfo<ConfirmLocalAuthSetupRouteArgs> page =
      _i18.PageInfo<ConfirmLocalAuthSetupRouteArgs>(name);
}

class ConfirmLocalAuthSetupRouteArgs {
  const ConfirmLocalAuthSetupRouteArgs({
    required this.pin,
    this.key,
  });

  final String pin;

  final _i19.Key? key;

  @override
  String toString() {
    return 'ConfirmLocalAuthSetupRouteArgs{pin: $pin, key: $key}';
  }
}

/// generated route for
/// [_i6.EditPinPage]
class EditPinRoute extends _i18.PageRouteInfo<void> {
  const EditPinRoute({List<_i18.PageRouteInfo>? children})
      : super(
          EditPinRoute.name,
          initialChildren: children,
        );

  static const String name = 'EditPinRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i7.ForgotPinPage]
class ForgotPinRoute extends _i18.PageRouteInfo<void> {
  const ForgotPinRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ForgotPinRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForgotPinRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i8.EnterLocalAuthPage]
class EnterLocalAuthRoute extends _i18.PageRouteInfo<void> {
  const EnterLocalAuthRoute({List<_i18.PageRouteInfo>? children})
      : super(
          EnterLocalAuthRoute.name,
          initialChildren: children,
        );

  static const String name = 'EnterLocalAuthRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i9.LocalAuthRootPage]
class LocalAuthRootRoute extends _i18.PageRouteInfo<void> {
  const LocalAuthRootRoute({List<_i18.PageRouteInfo>? children})
      : super(
          LocalAuthRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'LocalAuthRootRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SplashPage]
class SplashRoute extends _i18.PageRouteInfo<void> {
  const SplashRoute({List<_i18.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i11.AssetCarouselPage]
class AssetCarouselRoute extends _i18.PageRouteInfo<AssetCarouselRouteArgs> {
  AssetCarouselRoute({
    required String albumId,
    required int initialIndex,
    _i19.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          AssetCarouselRoute.name,
          args: AssetCarouselRouteArgs(
            albumId: albumId,
            initialIndex: initialIndex,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AssetCarouselRoute';

  static const _i18.PageInfo<AssetCarouselRouteArgs> page =
      _i18.PageInfo<AssetCarouselRouteArgs>(name);
}

class AssetCarouselRouteArgs {
  const AssetCarouselRouteArgs({
    required this.albumId,
    required this.initialIndex,
    this.key,
  });

  final String albumId;

  final int initialIndex;

  final _i19.Key? key;

  @override
  String toString() {
    return 'AssetCarouselRouteArgs{albumId: $albumId, initialIndex: $initialIndex, key: $key}';
  }
}

/// generated route for
/// [_i12.TrashPage]
class TrashRoute extends _i18.PageRouteInfo<void> {
  const TrashRoute({List<_i18.PageRouteInfo>? children})
      : super(
          TrashRoute.name,
          initialChildren: children,
        );

  static const String name = 'TrashRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i13.AssetListPage]
class AssetListRoute extends _i18.PageRouteInfo<AssetListRouteArgs> {
  AssetListRoute({
    required _i20.Album album,
    _i19.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          AssetListRoute.name,
          args: AssetListRouteArgs(
            album: album,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AssetListRoute';

  static const _i18.PageInfo<AssetListRouteArgs> page =
      _i18.PageInfo<AssetListRouteArgs>(name);
}

class AssetListRouteArgs {
  const AssetListRouteArgs({
    required this.album,
    this.key,
  });

  final _i20.Album album;

  final _i19.Key? key;

  @override
  String toString() {
    return 'AssetListRouteArgs{album: $album, key: $key}';
  }
}

/// generated route for
/// [_i14.AssetVideoPlayerPage]
class AssetVideoPlayerRoute
    extends _i18.PageRouteInfo<AssetVideoPlayerRouteArgs> {
  AssetVideoPlayerRoute({
    required String url,
    _i21.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          AssetVideoPlayerRoute.name,
          args: AssetVideoPlayerRouteArgs(
            url: url,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'AssetVideoPlayerRoute';

  static const _i18.PageInfo<AssetVideoPlayerRouteArgs> page =
      _i18.PageInfo<AssetVideoPlayerRouteArgs>(name);
}

class AssetVideoPlayerRouteArgs {
  const AssetVideoPlayerRouteArgs({
    required this.url,
    this.key,
  });

  final String url;

  final _i21.Key? key;

  @override
  String toString() {
    return 'AssetVideoPlayerRouteArgs{url: $url, key: $key}';
  }
}

/// generated route for
/// [_i15.MoveAssetsPage]
class MoveAssetsRoute extends _i18.PageRouteInfo<MoveAssetsRouteArgs> {
  MoveAssetsRoute({
    required String sourceAlbumId,
    required List<_i22.Asset> assets,
    required bool copy,
    _i19.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
          MoveAssetsRoute.name,
          args: MoveAssetsRouteArgs(
            sourceAlbumId: sourceAlbumId,
            assets: assets,
            copy: copy,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'MoveAssetsRoute';

  static const _i18.PageInfo<MoveAssetsRouteArgs> page =
      _i18.PageInfo<MoveAssetsRouteArgs>(name);
}

class MoveAssetsRouteArgs {
  const MoveAssetsRouteArgs({
    required this.sourceAlbumId,
    required this.assets,
    required this.copy,
    this.key,
  });

  final String sourceAlbumId;

  final List<_i22.Asset> assets;

  final bool copy;

  final _i19.Key? key;

  @override
  String toString() {
    return 'MoveAssetsRouteArgs{sourceAlbumId: $sourceAlbumId, assets: $assets, copy: $copy, key: $key}';
  }
}

/// generated route for
/// [_i16.AlbumListPage]
class AlbumListRoute extends _i18.PageRouteInfo<void> {
  const AlbumListRoute({List<_i18.PageRouteInfo>? children})
      : super(
          AlbumListRoute.name,
          initialChildren: children,
        );

  static const String name = 'AlbumListRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}

/// generated route for
/// [_i17.ProfilePage]
class ProfileRoute extends _i18.PageRouteInfo<void> {
  const ProfileRoute({List<_i18.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const _i18.PageInfo<void> page = _i18.PageInfo<void>(name);
}
