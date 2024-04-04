import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:flutter/material.dart';

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
    
  }
}
