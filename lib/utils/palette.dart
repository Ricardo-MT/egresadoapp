import 'package:flutter/material.dart';

final Map<int, Color> _red = {
  50: const Color(0xFFFF6680),
  100: const Color(0xFFFF5572),
  200: const Color(0xFFFD4D6B),
  300: const Color(0xFFFF4363),
  400: const Color(0xFFFF3960),
  500: MuiPalette.RED,
  600: const Color(0xFFFF1A40),
  700: const Color(0xFFFF1540),
  800: const Color(0xFFFF1500),
  900: const Color(0xFFFF2200),
};

class MuiPalette {
  static Color SUCCESS = const Color(0xFF45CB85);
  static Color INFO = const Color(0xFFFFC914);
  static Color ERROR = const Color(0xFFEB0346);
  static Color RED = const Color(0xFFFB2346);
  static Color GREEN = const Color(0xFF45CB85);
  static Color YELLOW = const Color(0xFFFFC914);
  static Color BLACK = const Color(0xFF2E282A);
  static Color DARK_GREY = const Color(0xFF707070);
  static Color MID_GREY = const Color(0xFFC7C7C7);
  static Color GREY = const Color(0xFFF5F5F5);
  static Color BACKGROUND = const Color(0xFFF2F2F2);
  static Color WHITE = const Color(0xFFFFFFFF);
  static Color FONT = const Color(0xFF3D3D3D);
  static Color FONT_HIGHLIGHT = const Color(0xFFFCFCFC);
  static Color BROWN = const Color(0xFF7B6367);
  static MaterialColor primary = MaterialColor(MuiPalette.RED.value, _red);
}
