// ignore_for_file: constant_identifier_names
// import 'package:eppicweb/widgets/muiicon/muiicon.dart';
import 'package:flutter/material.dart';
import "../button/muibutton.dart";

import '../../utils/dimensions.dart';
import '../../utils/palette.dart';
import 'styles/muibuttonstyles.dart';

const _gap = 18.0;

class MuiSpecialButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  // MuiIconVariant icon;
  MuiSpecialButton({
    Key? key,
    required this.onPressed,
    required this.text,
    // required this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimensions.controllerHeight,
      width: 242,
      child: TextButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: Colors.transparent,
              side: BorderSide(
                  width: Dimensions.borderWidth, color: MuiPalette.DARK_GREY),
              shape: semiRoundedShape,
              onPrimary: MuiPalette.DARK_GREY),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: _gap),
            child: Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: _gap),
                  // child: MuiIcon(
                  //   icon: icon,
                  //   color: MuiIconColor.accent,
                  // ),
                ),
                Text(
                  text,
                  style: contained
                      .textStyle(context)
                      .copyWith(fontSize: 17, fontWeight: FontWeight.w800),
                ),
              ],
            ),
          )),
    );
  }
}
