import 'package:common/src/theme/colors/abstract_color.dart';
import 'package:flutter/material.dart';

///Dark Color Palette
class DarkColors implements AbstractColor {
  @override
  Brightness get brightness => Brightness.dark;

  @override
  String get themeCode => 'dark';

  @override
  Color get primary => const Color(0xFF6644FF);
  @override
  Color get onPrimary => const Color(0xFF381E72);
  @override
  Color get primaryContainer => const Color(0xFF4F378B);
  @override
  Color get onPrimaryContainer => const Color(0xFFEADDFF);
  @override
  Color get secondary => const Color(0xff21242C);
  @override
  Color get onSecondary => const Color(0xff8F92A1);
  @override
  Color get secondaryContainer => const Color(0xFF4A4458);
  @override
  Color get onSecondaryContainer => const Color(0xFFE8DEF8);
  @override
  Color get tertiary => const Color(0xFFEFB8C8);
  @override
  Color get onTertiary => const Color(0xFF492532);
  @override
  Color get tertiaryContainer => const Color(0xFF633B48);
  @override
  Color get onTertiaryContainer => const Color(0xFFFFD8E4);
  @override
  Color get error => Colors.red;
  @override
  Color get onError => const Color(0xFF601410);
  @override
  Color get errorContainer => const Color(0xFF8C1D18);
  @override
  Color get onErrorContainer => const Color(0xFFF9DEDC);
  @override
  Color get outline => const Color(0xFF938F99);
  @override
  Color get background => const Color(0xFF181A1F);
  @override
  Color get onBackground => const Color(0xFFE6E1E5);
  @override
  Color get surface => const Color(0xFF1C1B1F);
  @override
  Color get onSurface => const Color(0xFFEEEEEE);
  @override
  Color get surfaceVariant => const Color(0xFF49454F);
  @override
  Color get onSurfaceVariant => const Color(0xFFCAC4D0);
  @override
  Color get inverseSurface => const Color(0xFFE6E1E5);
  @override
  Color get onInverseSurface => const Color(0xff8F92A1);
  @override
  Color get inversePrimary => const Color(0xFF9CA3AF);
  @override
  Color get shadow => const Color(0xFF000000);
  @override
  Color get surfaceTint => const Color(0xFFD0BCFF);
  @override
  Color get outlineVariant => const Color(0xFF21242C);
  @override
  Color get scrim => const Color(0xFF000000);
}
