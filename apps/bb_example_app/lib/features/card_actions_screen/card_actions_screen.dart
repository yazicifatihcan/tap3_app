import 'package:bb_example_app/features/card_actions_screen/controller/card_actions_controller.dart';
import 'package:bb_example_app/features/card_actions_screen/view/card_actions.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardActionsScreen extends StatelessWidget {
  
  const CardActionsScreen({required this.card,super.key});

  final CardInfoModel card;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardActionsController>(
      init: CardActionsController(card: card),
      builder: (CardActionsController controller) {
        return CardActions(
          controller: controller,
        );
      },
    );
  }
}
