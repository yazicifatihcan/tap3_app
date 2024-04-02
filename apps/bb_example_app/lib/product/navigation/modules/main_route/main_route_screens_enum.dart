// ignore_for_file: sort_constructors_first

///Enums for Project Radiuses
enum MainRouteScreenEnums {
  ///Value that represents [SplashScreen]
  homeScreen(
    '/home',
    'homeScreen',
  ),
  ;

  /// Gets the path value for [MainRouteScreenEnums] enum.
  final String path;

  /// Gets the path name for [MainRouteScreenEnums] enum.
  final String name;
  const MainRouteScreenEnums(this.path, this.name);
}