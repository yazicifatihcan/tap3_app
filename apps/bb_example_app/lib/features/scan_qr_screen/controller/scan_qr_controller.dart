// ignore_for_file: inference_failure_on_function_return_type

import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrController extends BaseControllerInterface {

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      onQrRead(scanData.code);
    });
  }

  Future<void> onQrRead (String? val)async{
    try {
      if(val==null){
        Navigator.pop(context);
        return;
      }
    } catch (e) {
      Navigator.pop(context);
    }
  }
}
