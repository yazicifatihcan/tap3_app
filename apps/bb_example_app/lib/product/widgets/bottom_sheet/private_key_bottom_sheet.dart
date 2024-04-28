import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/widgets/bottom_sheet/qr_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

class PrivateKeyBottomSheet extends BottomSheetWidget<void> {
  const PrivateKeyBottomSheet({required this.qrData, super.key})
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
              'MY PRIVATE KEY',
              style: context.titleLarge,
              textAlign: TextAlign.center,
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
            Text(qrData,textAlign: TextAlign.center,),
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

