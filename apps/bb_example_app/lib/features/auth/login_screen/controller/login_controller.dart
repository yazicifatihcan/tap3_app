// ignore_for_file: cascade_invocations


import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/card_handler.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';

///Controller for Example Screen
class LoginController extends BaseControllerInterface with CardHandler {
  
  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {
    });
  }

  void onTapOrderCard()=>'https://card.tap3.me/'.launchLink();

  void onTapHelp()=>'https://twitter.com/tap3wallet'.launchLink();

  Future<void> startNfcDiscover() async {
    await cardViewProcess(context);
  }

}
