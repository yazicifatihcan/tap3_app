import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:flutter/material.dart';

class PasswordChangeController extends BaseControllerInterface {
  PasswordChangeController({
    required this.card,
  });

  final CardInfoModel card;

  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  final TextEditingController cText = TextEditingController();
  final TextEditingController cTextRepeat = TextEditingController();

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
      Navigator.pop(context, cText.text);
    }
  }
}
