// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../auth/forgot_password/forgot_password_page.dart' as _i2;
import '../auth/sign_in/sign_in_page.dart' as _i1;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    SignInPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.SignInPage());
    },
    ForgotPasswordPageRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.ForgotPasswordPage());
    }
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(SignInPageRoute.name, path: '/'),
        _i3.RouteConfig(ForgotPasswordPageRoute.name,
            path: '/forgot-password-page')
      ];
}

/// generated route for
/// [_i1.SignInPage]
class SignInPageRoute extends _i3.PageRouteInfo<void> {
  const SignInPageRoute() : super(SignInPageRoute.name, path: '/');

  static const String name = 'SignInPageRoute';
}

/// generated route for
/// [_i2.ForgotPasswordPage]
class ForgotPasswordPageRoute extends _i3.PageRouteInfo<void> {
  const ForgotPasswordPageRoute()
      : super(ForgotPasswordPageRoute.name, path: '/forgot-password-page');

  static const String name = 'ForgotPasswordPageRoute';
}
