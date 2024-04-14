import 'package:bb_example_app/features/card_actions_screen/card_actions_screen.dart';
import 'package:bb_example_app/features/card_password_screen/card_password_screen.dart';
import 'package:bb_example_app/features/card_password_screen/controller/card_password_controller.dart';
import 'package:bb_example_app/features/discover_screen/discover_screen.dart';
import 'package:bb_example_app/features/home_screen/home_screen.dart';
import 'package:bb_example_app/features/nfc_payment_screen/nfc_payment_screen.dart';
import 'package:bb_example_app/features/payment_screen/payment_screen.dart';
import 'package:bb_example_app/features/scan_qr_screen/scan_qr_screen.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
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
    GoRoute(
      name: MainRouteScreenEnums.scanQrScreen.name,
      path: MainRouteScreenEnums.scanQrScreen.path,
      builder: (context, state) => const ScanQrScreen(),
    ),
    GoRoute(
        name: MainRouteScreenEnums.paymentScreen.name,
        path: MainRouteScreenEnums.paymentScreen.path,
        builder: (context, state) {
          final args = state.extra as String?;
          return PaymentScreen(
            adress: args,
          );
        },),
    GoRoute(
      name: MainRouteScreenEnums.cardActionsScreen.name,
      path: MainRouteScreenEnums.cardActionsScreen.path,
      builder: (context, state) {
        final args = state.extra! as CardInfoModel;
        return CardActionsScreen(card:args,);
      },
    ),
    GoRoute(
      name: MainRouteScreenEnums.nfcPaymentScreen.name,
      path: MainRouteScreenEnums.nfcPaymentScreen.path,
      builder: (context, state) {
        final args = state.extra! as double;
        return NfcPaymentScreen(
          totalAmount: args,
        );
      },
    ),
    GoRoute(
      name: MainRouteScreenEnums.cardPasscodeScreen.name,
      path: MainRouteScreenEnums.cardPasscodeScreen.path,
      builder: (context, state) {
        final args =  state.extra! as CardPasscodeArgumentModel;
        return CardPasswordScreen(args: args,);
      },
    ),
    GoRoute(
      name: MainRouteScreenEnums.discoverScreen.name,
      path: MainRouteScreenEnums.discoverScreen.path,
      builder: (context, state) {
        // final args =  state.extra! as double;
        return const DiscoverScreen();
      },
    ),
  ];
}
