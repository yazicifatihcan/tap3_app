import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:flutter/material.dart';

class PasswordController extends BaseControllerInterface {
  PasswordController({
    required this.card,
  });

  final CardInfoModel card;

  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  final TextEditingController cText = TextEditingController();

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  @override
  void onClose() {
    super.onClose();
    cText.dispose();
  }

  Future<void> onTapConfirm() async {
    if (fKey.currentState!.validate()) {
      final result = card.checkCardPassword(cText.text);
      if (result) {
        Navigator.pop(context, cText.text);
      } else {
        await AwesomeDialog(
          context: RoutingManager.instance.context!,
          dialogType: DialogType.error,
          animType: AnimType.topSlide,
          title: 'Wrong Password',
          desc: 'Incorrect password. Please try again.',
          btnOkOnPress: () {},
        ).show();
      }
    }
  }
}
