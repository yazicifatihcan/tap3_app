import 'package:bb_example_app/features/index.dart';
import 'package:bb_example_app/product/managers/auth_handler.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route_enums.dart';
import 'package:bb_example_app/product/navigation/modules/initial_route/initial_route.dart';
import 'package:bb_example_app/product/navigation/modules/initial_route/initial_route_enums.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Routing Manager for module
class RoutingManager extends AbstractRoutingManager {
  RoutingManager._privateConstructor();

  static final RoutingManager _instance = RoutingManager._privateConstructor();

  /// Routing Manager instance
  static RoutingManager get instance => _instance;

  /// Parent navigator key
  static final GlobalKey<NavigatorState> parentKey = GlobalKey();

  /// Shell navigator key
  static final GlobalKey<NavigatorState> shellKey = GlobalKey();

  /// Get the current context
  @override
  BuildContext? get context => parentKey.currentContext;

  final _router = GoRouter(
    observers: [NavigationHistoryObserver()],
    debugLogDiagnostics: true,
    initialLocation: '/',
    navigatorKey: parentKey,
    redirectLimit: 1,
    refreshListenable: SessionHandler.instance,
    routes: [
      InitialRoute.route,
      AuthRoute.route,
      ...MainRoute.route,
    ],
    redirect: (context, state) {
      final authHandler = SessionHandler.instance;
      if (authHandler.userAuthStatus == UserAuthStatus.notInitialized) {
        return InitialRouteScreens.splashScreen.path;
      } else if (_instance
          .isUnauthorizedAndNotAuthScreen(state.matchedLocation)) {
        return AuthRouteScreens.loginScreen.path;
      } else if (_instance.isAuthorizedAndAuthScreen(state.matchedLocation)) {
        return MainRouteScreenEnums.homeScreen.path;
      }
      return null;
    },
    errorPageBuilder: (context, state) => MaterialPage<void>(
      key: state.pageKey,
      child: const UnknownRouteScreen(),
    ),
  );

  @override
  GoRouter get router => _router;

  @override
  RouterDelegate<Object> get routerDelegate => _router.routerDelegate;

  @override
  RouteInformationParser<Object> get routeInformationParser =>
      _router.routeInformationParser;

  bool isUnauthorizedAndNotAuthScreen(String currentName) {
    final isUnauthorized =
        SessionHandler.instance.userAuthStatus == UserAuthStatus.unAuthorized;
    final isNotAuthScreen = AuthRouteScreens.values
                .indexWhere((element) => element.path == currentName) ==
            -1 ||
        currentName == InitialRouteScreens.splashScreen.path;

    return isUnauthorized && isNotAuthScreen;
  }

  bool isAuthorizedAndAuthScreen(String currentName) {
    final isAuthorized =
        SessionHandler.instance.userAuthStatus == UserAuthStatus.authorized;
    final isAuthScreen = AuthRouteScreens.values
                .indexWhere((element) => element.path == currentName) !=
            -1 ||
        currentName == InitialRouteScreens.splashScreen.path;

    return isAuthorized && isAuthScreen;
  }
}
