import 'package:bb_example_app/features/index.dart';
import 'package:bb_example_app/product/navigation/modules/bottom_navigation_route/bottom_navigation_route_enums.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Route Class for Drawer Routes
class BottomNavigationRoute {
  BottomNavigationRoute._();

  /// Bottom Navigation Router
  static final route = ShellRoute(
    navigatorKey: RoutingManager.shellKey,
    pageBuilder: (context, state, child) {
      return NoTransitionPage(
        child: BottomNavigationBarScreen(
          child: child,
        ),
      );
    },
    routes: [
      GoRoute(
        name: BottomNavigationRouteEnum.dashboardScreen.name,
        path: BottomNavigationRouteEnum.dashboardScreen.path,
        parentNavigatorKey: RoutingManager.shellKey,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: DashboardScreen(),
          );
        },
      ),
      GoRoute(
        name: BottomNavigationRouteEnum.transactionScreen.name,
        path: BottomNavigationRouteEnum.transactionScreen.path,
        parentNavigatorKey: RoutingManager.shellKey,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: Center(
              child: Text(AppLocalization.getLabels(context).transaction),
            ),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: RoutingManager.shellKey,
        name: BottomNavigationRouteEnum.taskScreen.name,
        path: BottomNavigationRouteEnum.taskScreen.path,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: Center(child: Text(AppLocalization.getLabels(context).task)),
          );
        },
      ),
      GoRoute(
        parentNavigatorKey: RoutingManager.shellKey,
        name: BottomNavigationRouteEnum.documentScreen.name,
        path: BottomNavigationRouteEnum.documentScreen.path,
        pageBuilder: (context, state) {
          return NoTransitionPage(
            child: Center(
              child: Text(AppLocalization.getLabels(context).document),
            ),
          );
        },
      ),
    ],
  );
}
