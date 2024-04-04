// ignore_for_file: inference_failure_on_function_return_type

import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/option_selection_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/qr_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:values/values.dart';

class HomeController extends BaseControllerInterface {
  final Rx<int> _selectedCardIndex = Rx(0);

  int get selectedCardIndex => _selectedCardIndex.value;
  set selectedCardIndex(int value) => _selectedCardIndex.value = value;

  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  final List<CardModel> cards = [
    CardModel(
      privateKey: 'privateKey1',
      cardNumber: '1234',
      usd: 100,
      matic: 200,
      imageUrl: 'https://tap3.me/bgs/gods_5_s.png',
    ),
    CardModel(
      privateKey: 'privateKey2',
      cardNumber: '9876',
      usd: 150,
      matic: 250,
      imageUrl: 'https://tap3.me/bgs/gods_1_w.png',
    ),
    CardModel(
      privateKey: 'privateKey3',
      cardNumber: '2468',
      usd: 200,
      matic: 300,
      imageUrl: 'https://tap3.me/bgs/capy.png',
    ),
  ];

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  void onTapChangeCard(int index) {
    if (selectedCardIndex != index) {
      selectedCardIndex = index;
    }
  }

  void onTapScanQr() =>
      context.pushNamed(MainRouteScreenEnums.scanQrScreen.name);

  void onTapShowQr(CardModel item) {
    const QrBottomSheet(qrData: 'qrData').showBottomSheet(context: context);
  }

  void onTapMoreOptions(CardModel item) {
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

  void onTapPayment(CardModel item) => context.pushNamed(
        MainRouteScreenEnums.paymentScreen.name,
      );

  void onTapDiscover(CardModel item) => context.pushNamed(
        MainRouteScreenEnums.discoverScreen.name,
      );
}

class CardModel {
  CardModel({
    required this.privateKey,
    required this.cardNumber,
    required this.usd,
    required this.matic,
    required this.imageUrl,
  });

  final String privateKey;
  final String cardNumber;
  final String imageUrl;
  final double usd;
  final double matic;
}
