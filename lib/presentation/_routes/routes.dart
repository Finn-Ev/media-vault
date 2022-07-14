import 'package:auto_route/auto_route.dart';
import 'package:media_vault/presentation/auth/forgot_password/forgot_password_page.dart';
import 'package:media_vault/presentation/auth/login/login_page.dart';
import 'package:media_vault/presentation/auth/register/register_page.dart';
import 'package:media_vault/presentation/home_page.dart';
import 'package:media_vault/presentation/splash/splash_page.dart';

// ❯❯ flutter packages pub run build_runner build
@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SplashPage, initial: true),
  AutoRoute(page: HomePage),
  AutoRoute(page: LoginPage),
  AutoRoute(page: RegisterPage),
  AutoRoute(page: ForgotPasswordPage),
])
class $AppRouter {}
