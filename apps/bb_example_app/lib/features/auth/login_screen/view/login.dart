import 'package:bb_example_app/features/auth/login_screen/controller/login_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/navigation/modules/auth_route/auth_route_enums.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/widgets/button/module_button.dart';
import 'package:bb_example_app/product/widgets/input/module_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:values/values.dart';

part 'components/login_form.dart';

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
                const IconAssets().nfcMobileIcon.svg(),
                const Spacer(),
                // Flexible(
                //   child: Padding(
                //     padding: EdgeInsets.all(ModulePadding.s.value),
                //     child: _LoginForm(controller: controller),
                //   ),
                // ),
                Text(
                  'Tap Your Card to Login',
                  textAlign: TextAlign.center,
                  style: context.headlineSmall,
                ),
                Text(
                  'Please tap your card to register',
                  textAlign: TextAlign.center,
                  style: context.bodyLarge.copyWith(color: context.onSecondary),
                ),
                const Spacer(),
                ModuleButton.primary(
                  onTap: () {
                    context.pushNamed(
                      AuthRouteScreens.passwordScreen.name,
                    );
                  },
                  title: 'Order a Card',
                ),
                SizedBox(height: ModulePadding.s.value),
                ModuleButton.secondary(onTap: () {}, title: 'Help'),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
