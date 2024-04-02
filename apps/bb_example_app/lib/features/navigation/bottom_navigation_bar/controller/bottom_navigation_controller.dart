import 'package:bb_example_app/product/base/controller/base_controller.dart';
import 'package:bb_example_app/product/navigation/modules/bottom_navigation_route/bottom_navigation_route_enums.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:values/values.dart';

///Controller for BottomNavigationBar
class BottomNavigationController extends BaseControllerInterface {
  final Rx<int> _selectedIndex = Rx(0);

  ///Getter for [_selectedIndex]
  int get selectedIndex => _selectedIndex.value;

  ///Setter for [_selectedIndex]
  set selectedIndex(int value) => _selectedIndex.value = value;

  ///Items to display on bottom bar.
  List<MyCustomBottomNavBarItem> tabs (BuildContext localeContext) => [
        MyCustomBottomNavBarItem(
          icon: const Icon(Icons.home),
          activeIcon: const Icon(Icons.home),
          label: localeContext.i10n.dashboard,
          location: BottomNavigationRouteEnum.dashboardScreen.name,
        ),
        MyCustomBottomNavBarItem(
          icon: const Icon(Icons.explore_outlined),
          activeIcon: const Icon(Icons.explore),
          label: localeContext.i10n.transaction,
          location: BottomNavigationRouteEnum.transactionScreen.name,
        ),
        MyCustomBottomNavBarItem(
          icon: const Icon(Icons.storefront_outlined),
          activeIcon: const Icon(Icons.storefront),
          label: localeContext.i10n.task,
          location: BottomNavigationRouteEnum.taskScreen.name,
        ),
        MyCustomBottomNavBarItem(
          icon: const Icon(Icons.account_circle_outlined),
          activeIcon: const Icon(Icons.account_circle),
          label: localeContext.i10n.document,
          location: BottomNavigationRouteEnum.documentScreen.name,
        ),
      ];

  ///Function that handles bottom bar taps.
  void onTapBottomBarItem(int index) {
    if (index == selectedIndex) return;
    final location = tabs(context)[index].location;
    selectedIndex = index;
    context.goNamed(location);
  }
}

///Class that has all required fields for BottomNavigationBar
class MyCustomBottomNavBarItem extends BottomNavigationBarItem {
  ///Class that has all required fields for BottomNavigationBar
  const MyCustomBottomNavBarItem({
    required this.location,
    required super.icon,
    super.label,
    Widget? activeIcon,
  }) : super(activeIcon: activeIcon ?? icon);

  ///Variable that holds location for GoRouter
  final String location;
}
