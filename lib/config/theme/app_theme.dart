import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme(Brightness darkMode) => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color(0xff2862F5),
      brightness: darkMode);
}
