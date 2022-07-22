import 'package:auto_route/auto_route.dart';
import 'package:media_vault/presentation/auth/forgot_password/forgot_password_page.dart';
import 'package:media_vault/presentation/auth/login/login_page.dart';
import 'package:media_vault/presentation/auth/register/register_page.dart';
import 'package:media_vault/presentation/media/album_list/album_list_page.dart';
import 'package:media_vault/presentation/media/asset_carousel/asset_carousel_page.dart';
import 'package:media_vault/presentation/media/asset_list/asset_list_page.dart';
import 'package:media_vault/presentation/media/asset_video_player/asset_video_player_page.dart';
import 'package:media_vault/presentation/other/settings/settings_page.dart';
import 'package:media_vault/presentation/other/splash/splash_page.dart';

// ❯❯ flutter packages pub run build_runner build
@MaterialAutoRouter(routes: <AutoRoute>[
  // General
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: SettingsPage),

  // Auth
  AutoRoute(page: LoginPage),
  AutoRoute(page: RegisterPage),
  AutoRoute(page: ForgotPasswordPage),

  // Media
  AutoRoute(
    page: AlbumListPage,
    maintainState: false, // to close the streams when navigating away from the page
  ),
  AutoRoute(page: AssetListPage),
  AutoRoute(page: AssetCarouselPage, fullscreenDialog: true),
  AutoRoute(page: AssetVideoPlayerPage, fullscreenDialog: true),
])
class $AppRouter {}
