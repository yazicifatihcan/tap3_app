import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardPasswordController extends BaseControllerInterface {

  CardPasswordController({required this.args, });
  
  final GlobalKey<FormState> fKey = GlobalKey();
  final TextEditingController cPassword = TextEditingController();


  final CardPasscodeArgumentModel args;

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  Future<void> onTapConfirm() async {
    if (fKey.currentState!.validate()) {
      await AwesomeDialog(
            context: RoutingManager.instance.context!,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Payment Success',
            desc: 'Payment succesfully completed.',
            btnOkOnPress: () {},
            ).show();
      context.goNamed(MainRouteScreenEnums.homeScreen.name);
    }
  }
}

class CardPasscodeArgumentModel {
  CardPasscodeArgumentModel({
    required this.card,
    required this.targetAdress,
    required this.totalAmount,
  });

  final CardInfoModel card;
  final String targetAdress;
  final double totalAmount;
}
