import 'package:flutter/material.dart';

import '../../../utils/palette.dart';

abstract class MuiButtonStyles {
  MuiButtonStyles();
  TextStyle textStyle(BuildContext context);
  ButtonStyle buttonStyle(BuildContext context);
}

final semiRoundedShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
const stadiumShape = StadiumBorder();

class ContainedButtonStyles extends MuiButtonStyles {
  @override
  TextStyle textStyle(BuildContext context) =>
      TextStyle(color: MuiPalette.FONT_HIGHLIGHT, fontWeight: FontWeight.w800);
  @override
  ButtonStyle buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      primary: MuiPalette.FONT, onPrimary: MuiPalette.DARK_GREY);
}

class LinkButtonStyles extends MuiButtonStyles {
  @override
  TextStyle textStyle(BuildContext context) =>
      TextStyle(fontWeight: FontWeight.bold, color: MuiPalette.FONT);
  @override
  ButtonStyle buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      primary: Colors.transparent, onPrimary: MuiPalette.FONT);
}

class LightLinkButtonStyles extends MuiButtonStyles {
  @override
  TextStyle textStyle(BuildContext context) =>
      TextStyle(fontWeight: FontWeight.bold, color: MuiPalette.WHITE);
  @override
  ButtonStyle buttonStyle(BuildContext context) => ElevatedButton.styleFrom(
      primary: Colors.transparent, onPrimary: MuiPalette.WHITE);
}
