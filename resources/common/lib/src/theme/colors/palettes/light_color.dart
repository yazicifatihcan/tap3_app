import 'package:common/src/theme/colors/abstract_color.dart';
import 'package:flutter/material.dart';

/// Color palette for Light Colors
class LightColors implements AbstractColor {
  @override
  Brightness get brightness => Brightness.light;

  @override
  String get themeCode => 'light';

  @override
  Color get primary => const Color(0xFF6644FF);
  @override
  Color get onPrimary => const Color(0xFFFFFFFF);
  @override
  Color get primaryContainer => const Color(0xFFEADDFF);
  @override
  Color get onPrimaryContainer => const Color(0xFF21005D);
  @override
  Color get secondary => const Color(0xFF625B71);
  @override
  Color get onSecondary => const Color(0xFFFFFFFF);
  @override
  Color get secondaryContainer => const Color(0xFFE8DEF8);
  @override
  Color get onSecondaryContainer => const Color(0xFF1D192B);
  @override
  Color get tertiary => const Color(0xFF7D5260);
  @override
  Color get onTertiary => const Color(0xFFFFFFFF);
  @override
  Color get tertiaryContainer => const Color(0xFFFFD8E4);
  @override
  Color get onTertiaryContainer => const Color(0xFF31111D);
  @override
  Color get error => const Color(0xFFB3261E);
  @override
  Color get onError => const Color(0xFFFFFFFF);
  @override
  Color get errorContainer => const Color(0xFFF9DEDC);
  @override
  Color get onErrorContainer => const Color(0xFF410E0B);
  @override
  Color get outline => const Color(0xFF79747E);
  @override
  Color get background => const Color(0xFFFFFBFE);
  @override
  Color get onBackground => const Color(0xFF1C1B1F);
  @override
  Color get surface => const Color(0xFFFFFBFE);
  @override
  Color get onSurface => const Color(0xFFEEEEEE);
  @override
  Color get surfaceVariant => const Color(0xFFE7E0EC);
  @override
  Color get onSurfaceVariant => const Color(0xFF49454F);
  @override
  Color get inverseSurface => const Color(0xFF313033);
  @override
  Color get onInverseSurface => const Color(0xFFF4EFF4);
  @override
  Color get inversePrimary => const Color(0xFFD0BCFF);
  @override
  Color get shadow => const Color(0xFF000000);
  @override
  Color get surfaceTint => const Color(0xFF6750A4);
  @override
  Color get outlineVariant => const Color(0xFFCAC4D0);
  @override
  Color get scrim => const Color(0xFF000000);
}
