import 'package:bb_example_app/features/scan_qr_screen/controller/scan_qr_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQr extends StatelessWidget {
  const ScanQr({required this.controller, super.key});

  final ScanQrController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text('Scan QR Code'),
      ),
      body: BaseView<ScanQrController>(
        controller: controller,
        child: Column(
          children: [
            Expanded(
              child: QRView(
                key: controller.qrKey,
                onQRViewCreated: controller.onQRViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
