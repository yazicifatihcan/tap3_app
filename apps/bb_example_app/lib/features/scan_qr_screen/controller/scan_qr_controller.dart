// ignore_for_file: inference_failure_on_function_return_type

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
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
      Navigator.pop(context);
      await AwesomeDialog(
            context: RoutingManager.instance.context!,
            dialogType: DialogType.success,
            animType: AnimType.topSlide,
            title: 'Payment Success',
            desc: 'Payment succesfully completed.',
            btnOkOnPress: () {},
            ).show();

      
    } catch (e) {
      Navigator.pop(context);
    }
  }
}
