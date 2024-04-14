import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

class QrBottomSheet extends BottomSheetWidget<void> {
  const QrBottomSheet({required this.qrData, super.key})
      : super(isScrollControlled: true);

  final String qrData;
  

  @override
  Widget build(BuildContext context) {
    bool isShareLoading = false;
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
              'MY QR CODE',
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
                        'Send only Bitcoin (BTC) to this adress. Sending any other coins may result in permanent loss.',
                        style: context.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: ModulePadding.m.value),
            Center(
              child: QrImageView(
                data: qrData,
                size: 250,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: ModulePadding.m.value),
            Text(qrData),
            SizedBox(height: ModulePadding.m.value),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleIconButton(
                  icon: const IconAssets().shareIcon.svg(),
                  label: 'Share',
                  onTap: () async{
                    if(!isShareLoading){
                      await Share.share(qrData);
                      isShareLoading=false;
                    }
                  },
                ),
                SizedBox(
                  width: ModulePadding.m.value,
                ),
                CircleIconButton(
                  icon: const IconAssets().copyIcon.svg(),
                  label: 'Copy',
                  onTap: () async{
                      await Clipboard.setData(ClipboardData(text: qrData));
                      ToastMessage.showToastMessage(
                      message: 'Succesfully copied.',
                      type: ToastMessageType.success,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  const CircleIconButton({
    required this.label,
    required this.onTap,
    required this.icon,
    super.key,
  });

  final String label;
  final VoidCallback onTap;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: context.background,
            child: icon,
          ),
          SizedBox(
            width: ModulePadding.xs.value,
          ),
          Text(label),
        ],
      ),
    );
  }
}

