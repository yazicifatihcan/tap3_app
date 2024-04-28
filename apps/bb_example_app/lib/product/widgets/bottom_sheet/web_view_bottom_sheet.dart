import 'package:bb_example_app/product/navigation/routing_manager.dart';
import 'package:bb_example_app/product/utility/enums/module_radius_enums.dart';
import 'package:bb_example_app/product/widgets/other/web_view.dart';
import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:widgets/widget.dart';

class WebViewBottomSheet extends BottomSheetWidget<void> {
  WebViewBottomSheet({required this.url, super.key})
      : super(
          isScrollControlled: true,
          constraints: BoxConstraints(
              maxHeight:
                  SizeConfig.screenHeight(RoutingManager.instance.context!) *
                      .9,
              minHeight:
                  SizeConfig.screenHeight(RoutingManager.instance.context!) *
                      .9,
                      ),
                      shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(ModuleRadius.m.value),
                topLeft: Radius.circular(ModuleRadius.m.value),
              ),
            )
        );

  final String url;

  @override
  Widget build(BuildContext context) {
    return MyWebView(
      url: url,
    );
  }
}
