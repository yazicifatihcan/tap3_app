import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/auth_handler.dart';
import 'package:bb_example_app/product/managers/wallet_parser.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PasswordController extends BaseControllerInterface {

  PasswordController({required this.card, });

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


  Future<void> onTapConfirm() async{
      if(fKey.currentState!.validate()){
        await AwesomeDialog(
            context: RoutingManager.instance.context!,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Card Added',
            desc: 'Card added to your wallet succesfully.',
            btnOkOnPress: () {},
            ).show();
        await sessionManager.addUserCard(card);
        if(sessionManager.userAuthStatus==UserAuthStatus.authorized){
          context.goNamed(MainRouteScreenEnums.homeScreen.name);
        }
      }
  }
}
