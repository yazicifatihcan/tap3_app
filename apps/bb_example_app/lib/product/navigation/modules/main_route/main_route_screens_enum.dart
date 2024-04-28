// ignore_for_file: sort_constructors_first

///Enums for Project Radiuses
enum MainRouteScreenEnums {
  ///Value that represents [SplashScreen]
  homeScreen(
    '/home',
    'homeScreen',
  ),
  scanQrScreen(
    '/scanQr',
    'scanQrScreen',
  ),
  paymentScreen(
    '/payment',
    'paymentScreen',
  ),
  passwordChangeScreen(
    '/passwordChange',
    'passwordChangeScreen',
  ),
  nfcPaymentScreen(
    '/nfcPayment',
    'nfcPaymentScreen',
  ),
  discoverScreen(
    '/discover',
    'discoverScreen',
  ),
  cardActionsScreen(
    '/cardActions',
    'cardActionsScreen',
  ),
  allCardsScreen(
    '/allCards',
    'allCardsScreen',
  ),
  webViewScreen(
    '/webView',
    'webViewScreen',
  ),
  ;

  /// Gets the path value for [MainRouteScreenEnums] enum.
  final String path;

  /// Gets the path name for [MainRouteScreenEnums] enum.
  final String name;
  const MainRouteScreenEnums(this.path, this.name);
}
