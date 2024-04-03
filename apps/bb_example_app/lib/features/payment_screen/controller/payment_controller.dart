import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PaymentController extends BaseControllerInterface {
  
  final Rx<String> _amount = Rx('');

  String get amount => _amount.value;
  set amount (String value) => _amount.value=value;

  
  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }



  void onTapNext(){
    if(!isAmountValid) return;
    context.pushReplacementNamed(
      MainRouteScreenEnums.nfcPaymentScreen.name,
      extra: totalAmount,
    );
  }

  double? get totalAmount => double.tryParse(amount);

  bool get isAmountValid => totalAmount!=null && totalAmount!>0;

  void onTapInput(String value){
    if(amount.contains('.')){
      final abc = amount.split('.');
      if(abc[1].length>=2){
        onTapDelete();
        amount=amount+value;
      }else{
        amount=amount+value;    
      }
    }else{
      amount=amount+value;
    }
  }

  void onTapDelete() {
    if (amount.isNotEmpty) {
      amount = amount.substring(0, amount.length - 1);
    }
  }

  void onTapDecimal(String value){
  if(amount.isEmpty){
    amount='0.';
  }
  if(!amount.contains(value)){
    onTapInput(value);
  }
  }

}
