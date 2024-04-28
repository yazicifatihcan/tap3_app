// ignore_for_file: inference_failure_on_function_return_type

import 'dart:async';
import 'dart:convert';

import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/card_handler.dart';
import 'package:bb_example_app/product/managers/encryption_service.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route_enums.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/option_selection_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/private_key_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/qr_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/web_view_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:values/values.dart';
import 'package:web3dart/crypto.dart';

class HomeController extends BaseControllerInterface with CardHandler{
  


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
        const Duration(seconds: 1),
        (timer)=>setCards(),
      );
    });
  }



  Future<void> setCards() async {
    await Future.forEach(sessionManager.userCards(), (elem) async {
      if (activeCards.indexWhere(
              (element) => element.cardInfo.cardId == elem.cardId) ==
          -1) {
        activeCards.add(await elem.cardUiModel());
      }
    });

    for (final card in activeCards) {
      if (sessionManager.userCards().indexWhere(
              (element) => element.cardId == card.cardInfo.cardId) ==
          -1) {
            activeCards.removeWhere((element) => element.cardInfo.cardId==card.cardInfo.cardId);
          }
    }

    activeCards = activeCards;
  }

  CardUIModel selectedCard() {
    final a = activeCards.firstWhere((element) =>
        sessionManager.selectedCard().adressToDisplay ==
        element.cardInfo.adressToDisplay);
  return a ;
  }

  List<CardUIModel> unSelectedCards() {
    var unSelectedCards = <CardUIModel>[];
    unSelectedCards = activeCards
        .where((element) =>
            sessionManager.selectedCard().adressToDisplay !=
            element.cardInfo.adressToDisplay)
        .toList();
    return unSelectedCards;
  }


  Future<void> onTapChangeCard(CardUIModel item) async {
    await sessionManager.setSelectedCard(item.cardInfo);
  }



  void onTapAllCards() =>
      context.pushNamed(MainRouteScreenEnums.allCardsScreen.name);
  

  void onTapScanQr() =>
      context.pushNamed(MainRouteScreenEnums.scanQrScreen.name);

  void onTapShowQr(CardUIModel item) {
    QrBottomSheet(qrData: item.adress).showBottomSheet(context: context);
  }

  void onTapMoreOptions(CardUIModel item) {
    OptionSelectionBottomSheet(
      options: [
        if(sessionManager.selectedCardAdress!= item.cardInfo.adressToDisplay) OptionItemModel(
          title: 'Set as default card',
          icon: const IconAssets().copyIcon,
          onTap: ()async{
            await sessionManager.setSelectedCard(item.cardInfo);
          }
        ),
        OptionItemModel(
          title: 'Buy Crypto',
          icon: const IconAssets().copyIcon,
          onTap: ()async{
            await buyCrypto(context: context, card: item);
          }
        ),
        OptionItemModel(
          title: 'Sell Crypto',
          icon: const IconAssets().copyIcon,
          onTap: ()async{
            await sellCrypto(context: context, card: item);
          }
        ),
        OptionItemModel(
          title: 'Show private key',
          icon: const IconAssets().copyIcon,
          onTap: ()async{
            await showPrivateKey(card: item,context: context);
          }
        ),
        OptionItemModel(
          title: 'Change password',
          icon: const IconAssets().copyIcon,
          onTap: ()async{
            await changePasswordProcess(
                context: context,
                card: item.cardInfo,
              );
          }
        ),
        OptionItemModel(
          title: 'Wipe the card',
          color: context.error,
          icon: const IconAssets().copyIcon,
          onTap: ()async{
            await wipeCard(card: item.cardInfo,context: context);
          }
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


