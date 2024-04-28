// ignore_for_file: inference_failure_on_function_return_type

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/auth_handler.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route_enums.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:flutter/services.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:go_router/go_router.dart';
import 'package:widgets/widget.dart';

class CardActionsController extends BaseControllerInterface {
  CardActionsController({
    required this.card,
  });

  final CardInfoModel card;

  final Rx<CardUIModel?> _cardItem = Rx(null);
  final Rx<bool> _animationCompleted = Rx(false);

  bool isShareLoading = false;

  CardUIModel? get cardItem => _cardItem.value;
  set cardItem(CardUIModel? value) => _cardItem.value = value;

  bool get animationCompleted => _animationCompleted.value;
  set animationCompleted(bool value) => _animationCompleted.value = value;

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {
      cardItem = await card.cardUiModel();
      await Future<void>.delayed(const Duration(seconds: 1));
    });
  }

  Future<void> copyAdress() async {
    await Clipboard.setData(ClipboardData(text: card.adressToDisplay));
    ToastMessage.showToastMessage(
      message: 'Succesfully copied.',
      type: ToastMessageType.success,
    );
  }

  bool isCardAlreadyExist() {
    final userCards = sessionManager.userCards();
    if (userCards.isEmpty) {
      return false;
    }
    return userCards.indexWhere((element) => element.cardId == card.cardId) != -1;
  }

  Future<void> onTapAddCard() async {
    final res = await context.pushNamed(AuthRouteScreens.passwordScreen.name,
        extra: card);
    if (res != null) {
      await AwesomeDialog(
        context: RoutingManager.instance.context!,
        dialogType: DialogType.success,
        animType: AnimType.topSlide,
        title: 'Card Added',
        desc: 'Card added to your wallet succesfully.',
        btnOkOnPress: () {},
      ).show();
      await sessionManager.addUserCard(card);
      if (sessionManager.userAuthStatus == UserAuthStatus.authorized) {
        context.goNamed(MainRouteScreenEnums.homeScreen.name);
      }
    }
  }

  Future<void> onTapAddMakePayment() async {
    await context.pushNamed(
      MainRouteScreenEnums.paymentScreen.name,
      extra: card.adressToDisplay,
    );
  }

  void onTapOpenExplorer() => card.openPolygonExplorer();
}
