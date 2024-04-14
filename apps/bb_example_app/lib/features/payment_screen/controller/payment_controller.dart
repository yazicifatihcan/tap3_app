import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/managers/card_handler.dart';
import 'package:bb_example_app/product/navigation/modules/main_route/main_route_screens_enum.dart';
import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

class PaymentController extends BaseControllerInterface with CardHandler {

  PaymentController({
    this.adress,
  });
  
  final Rx<String> _amount = Rx('');

  String get amount => _amount.value;
  set amount (String value) => _amount.value=value;

  final String? adress; 

  
  @override
  Future<void> onReady() async {
    await onReadyGeneric(() async {});
  }



  Future<void> onTapNext()async{
    if(!isAmountValid) return;
    await paymentProcess(
      context: context,
      //TODO
      payerCard: sessionManager.userCards()[0],
      totalAmount: totalAmount!,
      targetAdress: adress,
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
