// ignore_for_file: inference_failure_on_function_return_type

import 'dart:async';

import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/card_handler.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/option_selection_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/qr_bottom_sheet.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:values/values.dart';

class HomeController extends BaseControllerInterface with CardHandler{
  final Rx<int> _selectedCardIndex = Rx(0);

  int get selectedCardIndex => _selectedCardIndex.value;
  set selectedCardIndex(int value) => _selectedCardIndex.value = value;


  final Rx<List<CardUIModel>> _activeCards = Rx([]);

  List<CardUIModel> get activeCards => _activeCards.value;
  set activeCards(List<CardUIModel> value) => _activeCards
    ..firstRebuild = true
    ..value = value;

  Timer? cardRefresher;


  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {
      await setCards();
      cardRefresher = Timer.periodic(
        const Duration(seconds: 2),
        (timer)=>setCards(),
      );
    });
  }



  Future<void> setCards()async{
    await Future.forEach(sessionManager.userCards(), (elem) async {
      if (activeCards.indexWhere(
              (element) => element.cardInfo.cardId == elem.cardId) ==
          -1) {
        activeCards.add(await elem.cardUiModel());
      }
      });
      activeCards = activeCards;
  }


  void onTapChangeCard(int index) {
    if (selectedCardIndex != index) {
      selectedCardIndex = index;
    }
  }

  void onTapScanQr() =>
      context.pushNamed(MainRouteScreenEnums.scanQrScreen.name);

  void onTapShowQr(CardUIModel item) {
    QrBottomSheet(qrData: item.adress).showBottomSheet(context: context);
  }

  void onTapMoreOptions(CardUIModel item) {
    OptionSelectionBottomSheet(
      options: [
        OptionItemModel(
          title: 'Set card as new wallet',
          icon: const IconAssets().copyIcon,
        ),
        OptionItemModel(
          title: 'Show private key',
          icon: const IconAssets().copyIcon,
        ),
        OptionItemModel(
          title: 'Change password',
          icon: const IconAssets().copyIcon,
        ),
        OptionItemModel(
          title: 'Wipe the card',
          color: context.error,
          icon: const IconAssets().copyIcon,
        ),
      ],
    ).showBottomSheet(context: context);
  }

  Future<void> onTapPayment(CardUIModel item) async {
    await context.pushNamed(
      MainRouteScreenEnums.paymentScreen.name,
    );
  }

  Future<void> onTapAddCard() async {
    await cardViewProcess(context);
  }

  Future<void> onTapDiscover(CardUIModel item) async =>
      item.cardInfo.openPolygonExplorer();
}
