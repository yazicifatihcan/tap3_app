import 'package:bb_example_app/product/base/controller/base_controller.dart';

class PasswordController extends BaseControllerInterface {
  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});

  }

  void onTapConfirm() {
      sessionManager.logIn(token: 'token');
    }
}
