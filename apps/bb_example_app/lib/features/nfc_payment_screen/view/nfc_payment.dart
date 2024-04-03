import 'package:bb_example_app/features/nfc_payment_screen/controller/nfc_payment_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/double_extension.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/widgets/button/module_button.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';

class NfcPayment extends StatelessWidget {
  const NfcPayment({required this.controller, super.key});

  final NfcPaymentController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text('Payment'),
      ),
      body: BaseView<NfcPaymentController>(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.l.value),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              Text(
                controller.totalAmount.formatPrice(),
                textAlign: TextAlign.center,
                style: context.headlineLarge,
              ),
              const Spacer(),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Center(
                      child:
                          const LottieAssets().nfcAnimation.lottie(fit: BoxFit.cover),
                    ),
                    Text(
                      'Tap Your Card',
                      style: context.headlineSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: ModulePadding.xs.value,),
                    Text(
                      'Please tap the card you want to pay.',
                      style: context.titleMedium.copyWith(
                      ),
                    ),
                  ],
                ),
              ),  
              const Spacer(),
              ModuleButton.secondary(onTap: controller.onTapCancel, title: 'Cancel'),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
