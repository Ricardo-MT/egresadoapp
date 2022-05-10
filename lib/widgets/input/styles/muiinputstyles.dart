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
        focusedBorder: OutlineInputBorder(
            // borderRadius:
            //     BorderRadius.circular(Dimensions.borderRadiusControllers),
            borderSide:
                BorderSide(color: color, width: Dimensions.borderWidth)),
        enabledBorder: OutlineInputBorder(
            // borderRadius:
            //     BorderRadius.circular(Dimensions.borderRadiusControllers),
            borderSide: BorderSide(
                color: MuiPalette.FONT, width: Dimensions.borderWidth)),
        // border: OutlineInputBorder(
        //     borderRadius:
        //         BorderRadius.circular(Dimensions.borderRadiusControllers),
        //     borderSide:
        //         BorderSide(color: color, width: Dimensions.borderWidth)),
        // hintStyle: TextStyle(color: MuiPalette.DARK_BLUE),
        // suffixIcon: IconButton(
        // icon: Icon(
        //   Icons.remove_red_eye,
        //   color: color,
        // ),
        //   onPressed: () {},
        // ),
        labelStyle: TextStyle(color: color, fontWeight: FontWeight.bold));
  }
}
