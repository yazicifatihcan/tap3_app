import 'package:bb_example_app/features/password_change_screen/controller/password_change_controller.dart';
import 'package:bb_example_app/features/password_change_screen/view/password_change.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangeScreen extends StatelessWidget {
  const PasswordChangeScreen({required this.card, super.key});

  final CardInfoModel card;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordChangeController>(
      tag: UniqueKey().toString(),
      init: PasswordChangeController(card:card),
      builder: (PasswordChangeController controller) {
        return PasswordChange(
          controller: controller,
        );
      },
    );
  }
}
