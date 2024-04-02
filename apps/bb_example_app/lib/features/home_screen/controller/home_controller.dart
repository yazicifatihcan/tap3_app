// ignore_for_file: inference_failure_on_function_return_type

import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeController extends BaseControllerInterface {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {});
  }

  Function(QRViewController) get qrViewCreated => onQRViewCreated;
}
