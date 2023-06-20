import 'package:auto_route/auto_route.dart';
import 'package:media_vault/features/albums/presentation/album_list_page.dart';
import 'package:media_vault/features/assets/presentation/asset_carousel/asset_carousel_page.dart';
import 'package:media_vault/features/assets/presentation/asset_list/asset_list_page.dart';
import 'package:media_vault/features/assets/presentation/asset_list/trash/trash_page.dart';
import 'package:media_vault/features/assets/presentation/asset_video_player/asset_video_player_page.dart';
import 'package:media_vault/features/assets/presentation/move_assets/move_assets_page.dart';
import 'package:media_vault/features/auth/presentation/local_auth/edit_pin/edit_pin_page.dart';
import 'package:media_vault/features/auth/presentation/local_auth/enter_local_auth/enter_local_auth_page.dart';
import 'package:media_vault/features/auth/presentation/local_auth/forgot_pin/forgot_pin_page.dart';
import 'package:media_vault/features/auth/presentation/local_auth/local_auth_root_page.dart';
import 'package:media_vault/features/auth/presentation/local_auth/local_auth_setup/confirm_local_auth_setup_page.dart';
import 'package:media_vault/features/auth/presentation/local_auth/local_auth_setup/local_auth_setup_page.dart';
import 'package:media_vault/features/auth/presentation/remote_auth/forgot_password/forgot_password_page.dart';
import 'package:media_vault/features/auth/presentation/remote_auth/login/login_page.dart';
import 'package:media_vault/features/auth/presentation/remote_auth/register/register_page.dart';
import 'package:media_vault/other/settings/settings_page.dart';
import 'package:media_vault/other/splash/splash_page.dart';
import 'package:media_vault/routes/routes.gr.dart';

// ❯❯ flutter packages pub run build_runner build
@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: SettingsRoute.page),
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),
    AutoRoute(page: ForgotPasswordRoute.page),
    AutoRoute(page: LocalAuthRootRoute.page),
    AutoRoute(page: EnterLocalAuthRoute.page),
    AutoRoute(page: LocalAuthSetupRoute.page),
    AutoRoute(page: ConfirmLocalAuthSetupRoute.page),
    AutoRoute(page: EditPinRoute.page, maintainState: false),
    AutoRoute(page: ForgotPinRoute.page),
    AutoRoute(page: AlbumListRoute.page, maintainState: false),
    AutoRoute(page: AssetListRoute.page, maintainState: false),
    AutoRoute(page: AssetCarouselRoute.page, fullscreenDialog: false),
    AutoRoute(page: AssetVideoPlayerRoute.page, fullscreenDialog: true),
    AutoRoute(page: MoveAssetsRoute.page, fullscreenDialog: true),
    AutoRoute(page: TrashRoute.page, maintainState: false),
  ];
}
