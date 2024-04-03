import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CardPasswordController extends BaseControllerInterface {
  final GlobalKey<FormState> fKey = GlobalKey();
  final TextEditingController cPassword = TextEditingController();

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  Future<void> onTapConfirm() async {
    if (fKey.currentState!.validate()) {
      context.pop();
      await AwesomeDialog(
            context: RoutingManager.instance.context!,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Payment Success',
            desc: 'Payment succesfully completed.',
            btnOkOnPress: () {},
            ).show();
    }
  }
}
