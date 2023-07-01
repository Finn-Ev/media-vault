import 'package:auto_route/auto_route.dart';
import 'package:media_vault/routes/routes.gr.dart';

// ❯❯ dart run build_runner build
@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends $AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: SplashRoute.page, path: '/'),
    AutoRoute(page: ProfileRoute.page),
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
