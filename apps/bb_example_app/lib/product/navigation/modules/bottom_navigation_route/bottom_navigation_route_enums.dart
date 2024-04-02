// ignore_for_file: sort_constructors_first

enum BottomNavigationRouteEnum {
  dashboardScreen(
    '/dashboard',
    'dashboardScreen',
  ),
  transactionScreen(
    '/transaction',
    'transactionScreen',
  ),
  taskScreen(
    '/task',
    'taskScreen',
  ),
  documentScreen(
    '/document',
    'documentScreen',
  );

  /// Gets the path value for [BottomNavigationRouteEnum] enum.
  final String path;

  /// Gets the path name for [BottomNavigationRouteEnum] enum.
  final String name;
  const BottomNavigationRouteEnum(this.path, this.name);
}
