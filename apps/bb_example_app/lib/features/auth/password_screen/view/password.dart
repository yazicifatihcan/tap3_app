// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bb_example_app/features/auth/password_screen/controller/password_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/widgets/button/module_button.dart';
import 'package:bb_example_app/product/widgets/input/module_text_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:values/values.dart';

class Password extends StatelessWidget {
  const Password({
    required this.controller,
    super.key,
  });

  final PasswordController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: controller.unFocus,
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: context.pop,
            child: Icon(
              Icons.arrow_back,
              color: context.onSurface,
            ),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.all(ModulePadding.s.value),
          child: SizedBox(
            width: double.infinity,
            child: ModuleButton.primary(
              title: 'Confirm',
              onTap: controller.onTapConfirm,
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: BaseView<PasswordController>(
          controller: controller,
          child: Padding(
            padding: EdgeInsets.all(ModulePadding.s.value),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Password',
                  style: context.headlineSmall,
                ),
                Text(
                  'Lorem ipsum dolor sit amet.',
                  style: context.bodyMedium,
                ),
                const Spacer(),
                ModuleTextField(
                  obscureText: true,
                  controller: TextEditingController(),
                  suffixIcon: const Icon(
                    Icons.remove_red_eye,
                  ),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: context.primary,
                  ),
                ),
                const Spacer(
                  flex: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
