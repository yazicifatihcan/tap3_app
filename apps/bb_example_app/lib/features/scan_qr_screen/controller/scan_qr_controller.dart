// ignore_for_file: inference_failure_on_function_return_type

import 'package:api/api.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrController extends BaseControllerInterface {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? qrController;

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }

  @override
  void onClose() {
    super.onClose();
    qrController!.dispose();
  }

  void onQRViewCreated(QRViewController controller) {
    qrController = controller;
    controller.scannedDataStream.listen((scanData) {
      onQrRead(scanData.code);
    });
  }

  Future<void> onQrRead(String? val) async {
    try {
      if (val == null) {
        throw AppException('Value is empty.');
      }
      await context.pushNamed(
        MainRouteScreenEnums.paymentScreen.name,
        extra: val,
      );
    } catch (e) {
      await AwesomeDialog(
        context: RoutingManager.instance.context!,
        dialogType: DialogType.error,
        animType: AnimType.topSlide,
        title: 'Error Occured',
        desc: e.toString(),
        btnOkOnPress: () {},
      ).show();
      Navigator.pop(context);
    }
  }
}
