// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class BottomSheetHoldAndDrag extends StatelessWidget {
  const BottomSheetHoldAndDrag({
    super.key,
    this.height,
    this.width,
    this.color,
  });

  final double? height;
  final double? width;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        color: color ?? Theme.of(context).colorScheme.onSurface,
      ),
      child: SizedBox(
        width: height ?? 36,
        height: width ?? 4,
      ),
    );
  }
}
