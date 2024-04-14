import 'package:bb_example_app/features/auth/login_screen/login_screen.dart';
import 'package:bb_example_app/features/auth/password_screen/password_screen.dart';
import 'package:bb_example_app/features/card_actions_screen/card_actions_screen.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route_enums.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:go_router/go_router.dart';

/// Route Class for Auth Routes
class AuthRoute {
  AuthRoute._();

  static final route = ShellRoute(
    navigatorKey: RoutingManager.shellKey,
    pageBuilder: (context, state, child) {
      return NoTransitionPage(
        child: child,
      );
    },
    routes: [
      GoRoute(
        name: AuthRouteScreens.loginScreen.name,
        path: AuthRouteScreens.loginScreen.path,
        pageBuilder: (context, state) {
          return const NoTransitionPage(
            child: LoginScreen(),
          );
        },
      ),
      GoRoute(
      name: AuthRouteScreens.cardActionsScreen.name,
      path: AuthRouteScreens.cardActionsScreen.path,
      builder: (context, state) {
        final args = state.extra! as CardInfoModel;
        return CardActionsScreen(card:args,);
      },
    ),
    ],
  );
}
