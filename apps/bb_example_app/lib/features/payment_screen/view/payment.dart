import 'package:bb_example_app/features/home_screen/controller/home_controller.dart';
import 'package:bb_example_app/features/payment_screen/controller/payment_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/double_extension.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/utility/enums/module_radius_enums.dart';
import 'package:bb_example_app/product/widgets/button/module_button.dart';
import 'package:bb_example_app/product/widgets/input/numeric_keyboard.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:values/values.dart';

class Payment extends StatelessWidget {
  const Payment({required this.controller, super.key});

  final PaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text('Amount'),
      ),
      body: BaseView<PaymentController>(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.l.value),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: Obx(()=>Text(
                    controller.amount.isEmpty? '0,00' : 
                    controller.totalAmount?.formatPrice() ?? '',
                    style: context.headlineLarge,
                  ),),
                ),
              ),
              SizedBox(height: ModulePadding.m.value,),
              Obx(()=>
              ModuleButton.primary(
                  onTap: controller.onTapNext,
                  title: 'Next',
                  bgColor: !controller.isAmountValid ? Colors.grey : null,
              ),),
              SizedBox(height: ModulePadding.m.value,),
              NumericKeyboard(
                onKeyboardTap: controller.onTapInput,
                textColor: context.inverseSurface,
                leftIcon: const IconAssets().decimalIcon.svg(color: context.inverseSurface),
                rightIcon: const IconAssets().deleteIcon.svg(color: context.inverseSurface),
                leftButtonFn: ()=>controller.onTapDecimal('.'),
                rightButtonFn: controller.onTapDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
