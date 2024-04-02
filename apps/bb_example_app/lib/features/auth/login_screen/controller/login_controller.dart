import 'package:api/api.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

///Controller for Example Screen
class LoginController extends BaseControllerInterface {
  final GlobalKey<FormState> fKey = GlobalKey<FormState>();
  final TextEditingController cEmail = TextEditingController();
  final TextEditingController cPassword = TextEditingController();

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  Future<void> onTapLogin() async{
    if (fKey.currentState!.validate()) {
      sessionManager.userAuthStatus=UserAuthStatus.authorized;
      await sessionManager.logIn(token: 'Adm');
      ToastMessage.showToastMessage(
      message: context.i10n.succesfullyLoggedIn,
      type: ToastMessageType.success,
    );
    }
  }
}
