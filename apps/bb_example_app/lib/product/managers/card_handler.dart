// ignore_for_file: cascade_invocations

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/features/card_password_screen/controller/card_password_controller.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/model/nfc_response_model.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/nfc_payment_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';

mixin CardHandler {
  Future<void> mainScanner(
      {required BuildContext context,
      void Function(CardInfoModel)? onSuccess}) async {
    if (!await NfcManager.instance.isAvailable()) {
      
      await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'An Error Occurred',
            desc: 'NFC not available on this device.',
            btnOkOnPress: () {},
          ).show();
      return;
    }

    await NfcManager.instance.startSession(
      onDiscovered: (NfcTag tag) async {
        try {
          await NfcManager.instance.stopSession();
          if (Platform.isAndroid) {
            context.pop();
          }
          final nfcRes = NfcResponseModel.fromJson(
              jsonDecode(jsonEncode(tag.data)) as Map<String, dynamic>);
          if (nfcRes.parsedPayload() == null) {
            throw Exception('Card data empty.');
          }
          final cardInfo = CardInfoModel(url: nfcRes.parsedPayload()!);
          cardInfo.getParams();
          onSuccess?.call(cardInfo);
        } catch (e) {
          await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'An Error Occurred',
            desc: e.toString(),
            btnOkOnPress: () {},
          ).show();
        }
      },
    );
    if (Platform.isAndroid) {
      await const NfcPaymentBottomSheet().showBottomSheet(context: context);
    }
  }

  Future<void> cardViewProcess(BuildContext context) async {
    await mainScanner(
      context: context,
      onSuccess: (card) async {
        await context.pushNamed(
          MainRouteScreenEnums.cardActionsScreen.name,
          extra: card,
        );
      },
    );
  }

  Future<void> paymentProcess(
      {required BuildContext context,
      required CardInfoModel payerCard,
      required double totalAmount,
      String? targetAdress}) async {
    
    if (targetAdress != null) {
      if(targetAdress==payerCard.adressToDisplay){
        await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'An Error Occurred',
            desc: 'Sender and receiver can not have the same adress.',
            btnOkOnPress: () {},
          ).show();
        return ;
      }
      await context.pushNamed(
        MainRouteScreenEnums.cardPasscodeScreen.name,
        extra: CardPasscodeArgumentModel(
          card: payerCard,
          targetAdress: targetAdress,
          totalAmount: totalAmount,
        ),
      );
    } else {
      await mainScanner(
        context: context,
        onSuccess: (card) async {
          if(card.adressToDisplay==payerCard.adressToDisplay){
            await AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            animType: AnimType.topSlide,
            title: 'An Error Occurred',
            desc: 'Sender and receiver can not have the same adress.',
            btnOkOnPress: () {},
          ).show();
          return;
          }
          await context.pushNamed(
            MainRouteScreenEnums.cardPasscodeScreen.name,
            extra: CardPasscodeArgumentModel(
              card: payerCard,
              targetAdress: card.adressToDisplay,
              totalAmount: totalAmount,
            ),
          );
        },
      );
    }
  }


  
}
