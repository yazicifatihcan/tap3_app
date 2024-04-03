import 'package:bb_example_app/features/scan_qr_screen/controller/scan_qr_controller.dart';
import 'package:bb_example_app/features/scan_qr_screen/view/scan_qr.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ScanQrController>(
      init: ScanQrController(),
      builder: (ScanQrController controller) {
        return ScanQr(
          controller: controller,
        );
      },
    );
  }
}
