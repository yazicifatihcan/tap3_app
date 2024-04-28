import 'package:bb_example_app/features/all_cards_screen/controller/all_cards_controller.dart';
import 'package:bb_example_app/features/home_screen/view/home.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCards extends StatelessWidget {
  const AllCards({required this.controller, super.key});

  final AllCardsController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text('All Cards'),
      ),
      body: BaseView<AllCardsController>(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.l.value),
          child: Obx(() => ListView.separated(
            separatorBuilder: (context,index)=>SizedBox(height: ModulePadding.m.value,),
            itemCount: controller.activeCards.length,
                  itemBuilder:(context,index){
                    final item = controller.activeCards[index];
                      return GestureDetector(
                        onTap: ()=>controller.onTapMoreOptions(item),
                        child: CreditCard(
                          showNeon: false,
                          cardItem: item,
                          isSelected: true,
                          maticPrice:
                              controller.sessionManager.matic.quotes!.usd!.price!,
                        ),
                      );
                  },)

              // ListWheelScrollView(
              //   squeeze: 3,
              //   itemExtent: 200,
              //   physics: FixedExtentScrollPhysics(),
              //   children: List.generate(
              //     controller.activeCards.length,
              //     (index) {
              //       final item = controller.activeCards[index];
              //       return CreditCard(
              //           cardItem: item,
              //           isSelected: false,
              //           maticPrice: controller
              //               .sessionManager.matic.quotes!.usd!.price!,);
              //     },
              //   ),
              // ),
              ),
        ),
      ),
    );
  }
}
