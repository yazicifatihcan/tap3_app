import 'package:bb_example_app/features/home_screen/controller/home_controller.dart';
import 'package:bb_example_app/features/home_screen/view/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController controller) {
        return Home(
          controller: controller,
        );
      },
    );
  }
}
