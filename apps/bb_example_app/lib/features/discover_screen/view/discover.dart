// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bb_example_app/features/discover_screen/controller/discover_controller.dart';
import 'package:bb_example_app/product/base/base_view.dart';
import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:bb_example_app/product/utility/enums/module_radius_enums.dart';
import 'package:bb_example_app/product/widgets/input/module_text_field.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';

class Discover extends StatelessWidget {
  const Discover({
    required this.controller,
    super.key,
  });
  final DiscoverController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: AppBar(
        title: const Text('Discover'),
      ),
      body: SingleChildScrollView(
        child: BaseView<DiscoverController>(
          controller: controller,
          child: Padding(
            padding: EdgeInsets.all(ModulePadding.s.value),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ModuleTextField(
                  controller: TextEditingController(),
                  hintText: 'Search',
                  prefixIcon: const Icon(
                    Icons.search,
                  ),
                ),
                SizedBox(height: ModulePadding.s.value),
                SizedBox(
                  height: 36,
                  child: ListView.separated(
                    shrinkWrap: true,
                    clipBehavior: Clip.none,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return DecoratedBox(
                        decoration: BoxDecoration(
                          color: controller.selectedCardIndex == index
                              ? context.primary
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(ModuleRadius.xl.value),
                          border: Border.all(
                            color: context.primary,
                            width: 3,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ModulePadding.xs.value,
                            vertical: ModulePadding.xxs.value,
                          ),
                          child: Text(
                            'Swap',
                            style: context.titleSmall.copyWith(
                              color: controller.selectedCardIndex == index
                                  ? context.onSurface
                                  : context.primary,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(
                      width: ModulePadding.xxs.value,
                    ),
                    itemCount: 30,
                  ),
                ),
                SizedBox(height: ModulePadding.s.value),
                ListView.separated(
                  itemCount: 30,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => const ContactCard(),
                  separatorBuilder: (context, index) => SizedBox(
                    height: ModulePadding.xs.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  const ContactCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundColor: Colors.orange,
            ),
            SizedBox(width: ModulePadding.xs.value),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: context.titleMedium,
                ),
                Text(
                  'Description',
                  style: context.titleSmall.copyWith(
                    color: context.onInverseSurface,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right_outlined,
              color: context.onSurface,
            ),
          ],
        ),
      ],
    );
  }
}
