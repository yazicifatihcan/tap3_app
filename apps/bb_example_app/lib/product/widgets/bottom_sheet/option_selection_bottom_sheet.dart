import 'package:bb_example_app/product/utility/enums/module_padding_enums.dart';
import 'package:flutter/material.dart';
import 'package:values/values.dart';
import 'package:widgets/widget.dart';

// class QrBottomSheet extends BottomSheetWidget<void> {
//   const QrBottomSheet({required this.qrData, super.key})
//       : super(isScrollControlled: true);

class OptionSelectionBottomSheet extends BottomSheetWidget<void> {
  /// Generates [OptionSelectionBottomSheet]
  const OptionSelectionBottomSheet({
    required this.options,
    super.key,
  }): super(isScrollControlled: true);

  final List<OptionItemModel> options;


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(ModulePadding.m.value).copyWith(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const BottomSheetHoldAndDrag(),
            SizedBox(height: ModulePadding.l.value),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final item = options[index];
                  return GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                        if (item.subOptions.isEmpty) {
                          item.onTap?.call();
                        } else {
                          OptionSelectionBottomSheet(options: item.subOptions)
                              .showBottomSheet(context: context);
                        }
                    },
                    child: Row(
                      children: [
                        Expanded(
                            child: Text(
                              item.title,
                              style: context.titleLarge
                                  .copyWith(color: item.color),
                            ),
                          ),
                        item.icon.svg(color: item.color),
                      ],
                    ));
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: ModulePadding.m.value,
                ),
                itemCount: options.length,
              ),
            ),
            SizedBox(height: ModulePadding.xl.value),
          ],
        ),
      ),
    );
  }
}

class OptionItemModel {
  OptionItemModel({
    required this.title,
    this.color,
    required this.icon,
    this.onTap,
    this.subOptions = const [],
  });

  final String title;
  final SvgGeneralImage icon;
  final Color? color;
  final VoidCallback? onTap;
  final List<OptionItemModel> subOptions;
}
