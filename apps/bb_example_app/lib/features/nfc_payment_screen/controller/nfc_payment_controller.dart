import 'package:api/api.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcPaymentController extends BaseControllerInterface {

  NfcPaymentController({required this.totalAmount});

  final double totalAmount;

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {
      if(!await isNfcAvailable()){
        throw AppException('NFC is not available on this device.');
      }
      await NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          context.pushReplacementNamed(MainRouteScreenEnums.cardPasscodeScreen.name);
        },
      );

    });
  }

  @override
  void onClose() {
    super.onClose();
    NfcManager.instance.stopSession();
  }

  Future<bool> isNfcAvailable()async{
    try {
      final isAvailable = await NfcManager.instance.isAvailable();
      return isAvailable;
    } catch (e) {
      return false;
    }
  }


  void onTapCancel() => context.pop();

}


