import 'package:bb_example_app/features/home_screen/home_screen.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:go_router/go_router.dart';

/// Route Class for Initial Route
class MainRoute {
  MainRoute._();

  /// Initial Router
  static final route = [
    GoRoute(
      name: MainRouteScreenEnums.homeScreen.name,
      path: MainRouteScreenEnums.homeScreen.path,
      builder: (context, state) => const HomeScreen(),
    ),
  ];
}
