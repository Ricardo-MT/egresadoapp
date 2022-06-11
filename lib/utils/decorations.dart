import 'package:flutter/material.dart';

import '../widgets/button/styles/muibuttonstyles.dart';
import 'dimensions.dart';

final cardDecoration = ShapeDecoration(shape: semiRoundedShape, shadows: const [
  BoxShadow(
      color: Color.fromARGB(255, 239, 239, 239),
      blurRadius: 4,
      offset: Offset(0, 4))
]);

final cardPadding = EdgeInsets.all(Dimensions.cardSmallSpacing).copyWith(
    top: Dimensions.cardSmallSpacing * 2,
    left: Dimensions.cardSmallSpacing * 2);
final modalDecoration =
    ShapeDecoration(shape: semiRoundedShape, shadows: const [
  BoxShadow(
      color: Color.fromARGB(255, 78, 78, 78),
      blurRadius: 4,
      offset: Offset(0, 4))
]);
const modalPadding = EdgeInsets.all(30);
final borderRadiusForControllers =
    BorderRadius.circular(Dimensions.borderRadiusControllers);
const centerAlignment = Alignment.center;
const rightAlignment = Alignment.centerRight;
const leftAlignment = Alignment.centerLeft;

Alignment getRightAlignment(int total, int index, int crossAxisCount) {
  // if (crossAxisCount == 1) {
  //   return centerAlignment;
  // }
  // if (index % crossAxisCount == 0) {
  //   return rightAlignment;
  // }
  // if (index % crossAxisCount == crossAxisCount - 1) {
  //   return leftAlignment;
  // }
  return centerAlignment;
}
