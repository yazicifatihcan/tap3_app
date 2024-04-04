import 'package:bb_example_app/features/discover_screen/controller/discover_controller.dart';
import 'package:bb_example_app/features/discover_screen/view/discover.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DiscoverController>(
      init: DiscoverController(),
      builder: (DiscoverController controller) {
        return Discover(
          controller: controller,
        );
      },
    );
  }
}
