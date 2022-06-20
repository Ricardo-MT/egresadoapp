import 'package:flutter/material.dart';

import '../../../utils/dimensions.dart';
import '../../../utils/palette.dart';

abstract class MuiInputStyles {
  InputDecoration inputDecoration(
      BuildContext context, bool filled, Color _color);
}

class OutLinedInputStyles extends MuiInputStyles {
  OutLinedInputStyles();
  @override
  InputDecoration inputDecoration(
      BuildContext context, bool filled, Color? _color) {
    Color color = _color ?? MuiPalette.FONT;
    return InputDecoration(
        focusColor: MuiPalette.FONT,
        filled: filled,
        fillColor: MuiPalette.GREY,
        hoverColor: MuiPalette.GREY,
        helperText: "",
        errorBorder: const OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.red, width: Dimensions.borderWidth)),
        focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: color, width: Dimensions.borderWidth)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: MuiPalette.FONT, width: Dimensions.borderWidth)),
        labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }
}
