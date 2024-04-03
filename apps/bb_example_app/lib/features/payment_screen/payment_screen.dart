import 'package:bb_example_app/features/payment_screen/controller/payment_controller.dart';
import 'package:bb_example_app/features/payment_screen/view/payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      builder: (PaymentController controller) {
        return Payment(
          controller: controller,
        );
      },
    );
  }
}
