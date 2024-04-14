import 'package:bb_example_app/features/payment_screen/controller/payment_controller.dart';
import 'package:bb_example_app/features/payment_screen/view/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {

  
  const PaymentScreen({super.key, this.adress});

  final String? adress; 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(adress: adress),
      builder: (PaymentController controller) {
        return Payment(
          controller: controller,
        );
      },
    );
  }
}
