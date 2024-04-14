import 'package:bb_example_app/features/auth/login_screen/controller/login_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/widgets/button/module_button.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';


///Widget for Login Screen View
class Login extends StatelessWidget {
  ///Widget for Login Screen View
  const Login({required this.controller, super.key});

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.unFocus,
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const IconAssets().top3Logo.svg(
                fit: BoxFit.none,
                color: Colors.white,
              ),
        ),

        ///Body
        body: BaseView<LoginController>(
          controller: controller,
          child: Padding(
            padding: EdgeInsets.all(ModulePadding.s.value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Spacer(),
                const IconAssets().nfcMobileIcon.svg().slideAnimation(order: 1),
                const Spacer(),
                Text(
                  'Scan Your Card to Login',
                  textAlign: TextAlign.center,
                  style: context.headlineSmall,
                ).slideAnimation(order: 2),
                Text(
                  'Please scan your card to login',
                  textAlign: TextAlign.center,
                  style: context.bodyLarge.copyWith(color: context.onSecondary),
                ).slideAnimation(order: 3),
                const Spacer(),
                ModuleButton.primary(
                  onTap: controller.startNfcDiscover,
                  title: 'Scan Your Card',
                ).slideAnimation(order: 4),
                SizedBox(height: ModulePadding.s.value),
                ModuleButton.primary(
                  onTap: controller.onTapOrderCard,
                  title: 'Order a Card',
                ).slideAnimation(order: 5),
                SizedBox(height: ModulePadding.s.value),
                ModuleButton.secondary(
                        onTap: controller.onTapHelp, title: 'Help',)
                    .slideAnimation(order: 6),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
