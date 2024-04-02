import 'package:api/api.dart';
import 'package:bb_example_app/features/dashboard_screen/controller/dashboard_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

part 'components/character_card.dart';

///Widget for Example Screen View
class Dashboard extends StatelessWidget {
  ///Widget for Example Screen View
  const Dashboard({required this.controller, super.key});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,

      ///Body
      body: BaseView<DashboardController>(
        controller: controller,
        child: Padding(
          padding: EdgeInsets.all(ModulePadding.s.value),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                    icon: const Icon(Icons.language),
                    items: supportedLocalization.values
                        .map(
                          (e) => DropdownMenuItem(
                            value: e.lanCode,
                            child: Text(e.localizationTitle),
                          ),
                        )
                        .toList(),
                    onChanged: (lanCode) =>
                        AppStateController.instance.setLocale(lanCode!),
                    value: AppStateController.instance.getCurrentLanCode,
                  ),
                  SizedBox(
                    width: ModulePadding.s.value,
                  ),
                  Switch(
                    value: false,
                    onChanged: (_) => controller.onChangeThemeSwitch(),
                  ),
                  SizedBox(
                    width: ModulePadding.s.value,
                  ),
                  IconButton(
                    onPressed: controller.onTapLogout,
                    icon: const Icon(Icons.logout),
                  ),
                ],
              ),
              SizedBox(height: ModulePadding.s.value),
              Flexible(
                child: Obx(
                  () => ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final item = controller.characters.results![index];
                      return _CharacterCard(item: item).slideAnimation(
                        order: 1,
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      height: ModulePadding.s.value,
                    ),
                    itemCount: controller.characters.results?.length ?? 0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
