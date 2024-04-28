import 'package:bb_example_app/features/all_cards_screen/controller/all_cards_controller.dart';
import 'package:bb_example_app/features/all_cards_screen/view/all_cards.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCardsScreen extends StatelessWidget {
  const AllCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AllCardsController>(
      init: AllCardsController(),
      builder: (AllCardsController controller) {
        return AllCards(
          controller: controller,
        );
      },
    );
  }
}
