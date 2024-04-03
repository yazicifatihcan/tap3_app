import 'package:bb_example_app/features/nfc_payment_screen/controller/nfc_payment_controller.dart';
import 'package:bb_example_app/features/nfc_payment_screen/view/nfc_payment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NfcPaymentScreen extends StatelessWidget {
  const NfcPaymentScreen({required this.totalAmount, super.key});

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NfcPaymentController>(
      init: NfcPaymentController(totalAmount: totalAmount),
      builder: (NfcPaymentController controller) {
        return NfcPayment(
          controller: controller,
        );
      },
    );
  }
}
