import 'package:flutter/material.dart';

class Dimensions {
  static const double borderWidth = 1.6;
  static const double borderRadiusControllers = 12;
  static const double controllerHeight = 48;
  static const double innerGap = 18;
  static const double cardSmallSpacing = 10;
  static const double cardLargeSpacing = cardSmallSpacing * 2.5;
  static const double defaultCardWidth = 520;
  static const double defaultCardHeight = 420;
  static const double labelFontSize = 12;
  static const double cardTitleFontSize = labelFontSize + 3;
  static const double pageInsetGap = 30;
  static const int animationDuration = 200;
}

bool isMobileView(BuildContext context) {
  return MediaQuery.of(context).size.width < 780;
}
