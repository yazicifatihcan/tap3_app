// ignore_for_file: cascade_invocations

import 'dart:convert';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/managers/auth_handler.dart';
import 'package:bb_example_app/product/managers/encryption_service.dart';
import 'package:bb_example_app/product/managers/eth_client.dart';

import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/model/nfc_response_model.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route_enums.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/nfc_payment_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/private_key_bottom_sheet.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/web_view_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:web3dart/crypto.dart';
import 'package:web3dart/web3dart.dart';

mixin CardHandler {
  
  Future<void> mainScanner(
      {
    required BuildContext context,
    void Function(CardInfoModel, NfcTag)? onSuccess,
    bool shouldStopAfterDiscover=true,
  }) async {
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
          if(shouldStopAfterDiscover){
            await NfcManager.instance.stopSession();
          }
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
          onSuccess?.call(cardInfo,tag);
        } catch (e) {
          if(!shouldStopAfterDiscover){
            await NfcManager.instance.stopSession();
          }
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
      onSuccess: (card,tag) async {
        await context.pushNamed(
          MainRouteScreenEnums.cardActionsScreen.name,
          extra: card,
        );
      },
    );
  }

  Future<void> changePasswordProcess({
    required BuildContext context,
    required CardInfoModel card,
  }) async {
    final res = await context.pushNamed(
      AuthRouteScreens.passwordScreen.name,
      extra: card,
    );
    if ((res as String?) != null) {
      final newPassword = await context.pushNamed(
        MainRouteScreenEnums.passwordChangeScreen.name,
        extra: card,
      );
      if ((newPassword as String?) != null) {
        final newUrl = card.generateNewUrlWithPassword(
            newPassword: newPassword!, oldPassword: res!);
        await mainScanner(
          context: context,
          shouldStopAfterDiscover: false,
          onSuccess: (scannedCard, tag) async {
            if (card.adressToDisplay != scannedCard.adressToDisplay) {
              await NfcManager.instance.stopSession();
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: 'An Error Occurred',
                desc:
                    'Please scan the same card that you want to change the password.',
                btnOkOnPress: () {},
              ).show();
              await NfcManager.instance.stopSession();
              return;
            }
            final ndef = Ndef.from(tag);
            if (ndef == null || !ndef.isWritable) {
              await NfcManager.instance.stopSession();
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: 'An Error Occurred',
                desc: 'Card is not writable.',
                btnOkOnPress: () {},
              ).show();
              return;
            }
            final message = NdefMessage([
              NdefRecord.createUri(Uri.parse(newUrl)),
            ]);
            try {
              await ndef.write(message);
              await NfcManager.instance.stopSession();
              await SessionHandler.instance.changeCardInfo(
                card,
                CardInfoModel(url: newUrl),
              );
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.topSlide,
                title: 'Success!',
                desc: 'Password changed succesfully.',
                btnOkOnPress: () {},
              ).show();
            } catch (e) {
              await NfcManager.instance.stopSession();
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: 'An Error Occurred',
                desc: 'An error occurred while changing password.',
                btnOkOnPress: () {},
              ).show();
              return;
            }
          },
        );
      }
    }
  }


  Future<void> wipeCard({
    required BuildContext context,
    required CardInfoModel card,
  }) async {
    final res = await context.pushNamed(
      AuthRouteScreens.passwordScreen.name,
      extra: card,
    );
    if ((res as String?) != null) {

        await mainScanner(
          context: context,
          shouldStopAfterDiscover: false,
          onSuccess: (scannedCard, tag) async {
            if (card.adressToDisplay != scannedCard.adressToDisplay) {
              await NfcManager.instance.stopSession();
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: 'An Error Occurred',
                desc:
                    'Please scan the same card that you want to wipe.',
                btnOkOnPress: () {},
              ).show();
              await NfcManager.instance.stopSession();
              return;
            }
            final ndef = Ndef.from(tag);
            if (ndef == null || !ndef.isWritable) {
              await NfcManager.instance.stopSession();
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: 'An Error Occurred',
                desc: 'Card is not writable.',
                btnOkOnPress: () {},
              ).show();
              return;
            }
            final message = NdefMessage([]);
            try {
              await ndef.write(message);
              await NfcManager.instance.stopSession();
              await SessionHandler.instance.removeUserCard(
                card,
              );
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.topSlide,
                title: 'Success!',
                desc: 'Card wiped succesfully.',
                btnOkOnPress: () {},
              ).show();
            } catch (e) {
              await NfcManager.instance.stopSession();
              await AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: 'An Error Occurred',
                desc: 'An error occurred while wiping the card.',
                btnOkOnPress: () {},
              ).show();
              return;
            }
          },
        );
    }
  }



    String getUrl({required CardUIModel item,required bool isStaging,required transakEnum type}){
  const apiKey = '32fac031-92ef-4b0c-b972-86e7b75861da';
  const apiKeyStaging = 'bfaa7c4c-7768-4de2-8239-cb134a03e764';
  const network = 'polygon';
  const cryptoCode = 'MATIC';
  const endpoint = 'https://global.transak.com/';
  const endPointStaging = 'https://global-stg.transak.com/';
  late String url;
    if (isStaging) {
      url='$endPointStaging?apiKey=$apiKeyStaging';
    } else {
      url='$endpoint?apiKey=$apiKey';
    }
  
   url ='$url&network=$network&cryptoCurrencyCode=$cryptoCode&productsAvailed=${type.name}&exchangeScreenTitle=${type.name}%20Crypto';

  if(type==transakEnum.BUY){
    url = '$url&walletAddress=${item.adress}';
  }else{
    url += '&cryptoAmount=${((100*item.etherBalance-10).round())/100}';
  }
   return url;
  }

  Future<void> buyCrypto({required BuildContext context,required CardUIModel card,})async{
    final res = await context.pushNamed(
      AuthRouteScreens.passwordScreen.name,
      extra: card.cardInfo,
    );
    if ((res as String?) != null) {
      await WebViewBottomSheet(
              url: getUrl(item: card, isStaging: false, type: transakEnum.BUY))
          .showBottomSheet(context: context);
    }
  }

  Future<void> sellCrypto({required BuildContext context,required CardUIModel card,})async{
    final res = await context.pushNamed(
      AuthRouteScreens.passwordScreen.name,
      extra: card.cardInfo,
    );
    if ((res as String?) != null) {
      await WebViewBottomSheet(
              url: getUrl(item: card, isStaging: false, type: transakEnum.SELL))
          .showBottomSheet(context: context);
    }
  }

  Future<void> showPrivateKey({
    required BuildContext context,
    required CardUIModel card,
  }) async {
    final res = await context.pushNamed(
      AuthRouteScreens.passwordScreen.name,
      extra: card.cardInfo,
    );
    if (res != null) {
      final privateKey = bytesToHex(
        utf8.encode(
          EncryptionService()
              .decryptAESCryptoJS(card.cardInfo.privateKey, res as String),
        ),
      );
      await PrivateKeyBottomSheet(qrData: privateKey)
          .showBottomSheet(context: context);
    }
  }
  

  Future<void> paymentProcess(
      {required BuildContext context,
      required CardInfoModel payerCard,
      required double totalAmount,
      String? targetAdress}) async {
    if (targetAdress != null) {
      if (targetAdress == payerCard.adressToDisplay) {
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
      final res = await context.pushNamed(
        AuthRouteScreens.passwordScreen.name,
        extra: payerCard,
      );
      if ((res as String?) != null) {
        try{final decryptedKey = EncryptionService().decryptAESCryptoJS(
          payerCard.privateKey,
          res!,
        );
        final credentials = EthPrivateKey.fromHex(
          bytesToHex(
            utf8.encode(decryptedKey),
          ),
        );
        await EthClient.instance.pay(credentials, targetAdress, totalAmount);}
        catch(e){
          await AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          title: 'An Error Occurred',
          desc: e.toString(),
          btnOkOnPress: () {},
        ).show();
        return;
        }
      }
    } else {
      await mainScanner(
        context: context,
        onSuccess: (card, tag) async {
          if (card.adressToDisplay == payerCard.adressToDisplay) {
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
          final res = await context.pushNamed(
            AuthRouteScreens.passwordScreen.name,
            extra: payerCard,
          );
          if ((res as String?) != null) {
        try{final decryptedKey = EncryptionService().decryptAESCryptoJS(
          payerCard.privateKey,
          res!,
        );
        final credentials = EthPrivateKey.fromHex(
          bytesToHex(
            utf8.encode(decryptedKey),
          ),
        );
        await EthClient.instance.pay(credentials , card.adressToDisplay, totalAmount);}
        catch(e){
          await AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          title: 'An Error Occurred',
          desc: e.toString(),
          btnOkOnPress: () {},
        ).show();
        return;
        }
      }
        },
      );
    }
  }
}

enum transakEnum {BUY,SELL}