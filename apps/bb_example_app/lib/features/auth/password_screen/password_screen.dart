import 'package:bb_example_app/features/auth/password_screen/controller/password_controller.dart';
import 'package:bb_example_app/features/auth/password_screen/view/password.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordScreen extends StatelessWidget {
  const PasswordScreen({required this.card, super.key});

  final CardInfoModel card;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PasswordController>(
      tag: UniqueKey().toString(),
      init: PasswordController(card:card),
      builder: (PasswordController controller) {
        return Password(
          controller: controller,
        );
      },
    );
  }
}
