import 'package:bb_example_app/features/dashboard_screen/controller/dashboard_controller.dart';
import 'package:bb_example_app/features/dashboard_screen/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

///Widget for initializing GetxController for Example Screen
class DashboardScreen extends StatelessWidget {
  ///Widget for initializing GetxController for Example Screen
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: DashboardController(),
      builder: (controller) => Dashboard(controller: controller),
    );
  }
}
