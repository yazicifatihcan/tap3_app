import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:get/get.dart';

class DiscoverController extends BaseControllerInterface {
  final Rx<int> _selectedCardIndex = Rx(0);

  int get selectedCardIndex => _selectedCardIndex.value;
  set selectedCardIndex(int value) => _selectedCardIndex.value = value;

  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }
  
}
