import 'package:auto_route/auto_route.dart';
import 'package:media_vault/presentation/auth/forgot_password/forgot_password_page.dart';
import 'package:media_vault/presentation/auth/sign_in/sign_in_page.dart';

// run ❯ flutter packages pub run build_runner build
@MaterialAutoRouter(routes: <AutoRoute>[
  AutoRoute(page: SignInPage, initial: true),
  AutoRoute(page: ForgotPasswordPage),
])
class $AppRouter {}
