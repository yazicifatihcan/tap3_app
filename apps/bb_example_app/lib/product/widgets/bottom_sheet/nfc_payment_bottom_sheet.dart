import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

class NfcPaymentBottomSheet extends BottomSheetWidget<void> {
  const NfcPaymentBottomSheet({super.key})
      : super(isScrollControlled: true);
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(ModulePadding.m.value).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHoldAndDrag(),
            SizedBox(height: ModulePadding.l.value),
            Text(
              'SCAN CARD',
              style: context.titleLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: ModulePadding.m.value),
            Card(
              color: context.primary.withOpacity(.2),
              child: Padding(
                padding: EdgeInsets.all(ModulePadding.xs.value),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IconAssets().infoCircle.svg(),
                    SizedBox(
                      width: ModulePadding.xxs.value,
                    ),
                    Expanded(
                      child: Text(
                        'Scan the card you would like to make the payment on.',
                        style: context.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ModulePadding.m.value),
            const LottieAssets().nfcAnimation.lottie(height: 250,width: 250),
            SizedBox(height: ModulePadding.m.value),
          ],
        ),
      ),
    );
  }
}
