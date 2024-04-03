import 'package:bb_example_app/features/auth/password_screen/controller/password_controller.dart';
import 'package:bb_example_app/features/auth/password_screen/view/password.dart';
import 'package:bb_example_app/features/card_password_screen/controller/card_password_controller.dart';
import 'package:bb_example_app/features/card_password_screen/view/card_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardPasswordScreen extends StatelessWidget {
  const CardPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardPasswordController>(
      init: CardPasswordController(),
      builder: (CardPasswordController controller) {
        return CardPassword(
          controller: controller,
        );
      },
    );
  }
}
