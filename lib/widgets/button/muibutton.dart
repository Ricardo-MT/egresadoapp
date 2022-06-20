// ignore_for_file: constant_identifier_names
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

import 'styles/muibuttonstyles.dart';

class MuiButton extends StatelessWidget {
  String text;
  VoidCallback onPressed;
  MuiButtonVariant variant;
  double fontSize;
  EdgeInsets? customInset;
  MuiButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.fontSize = Dimensions.labelFontSize,
      this.customInset,
      this.variant = MuiButtonVariant.CONTAINED})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    MuiButtonStyles style = contained;
    EdgeInsets inset = _padding;
    switch (variant) {
      case MuiButtonVariant.CONTAINED:
        style = contained;
        inset = _padding;
        break;
      case MuiButtonVariant.LINK:
        style = link;
        inset = _minimalPadding;
        break;
      case MuiButtonVariant.LIGHT_LINK:
        style = light_link;
        inset = _minimalPadding;
        break;
      default:
        style = contained;
        break;
    }
    inset = customInset ?? inset;

    return TextButton(
        onPressed: onPressed,
        style: style.buttonStyle(context),
        child: Padding(
          padding: inset,
          child: Text(
            text,
            style: style.textStyle(context).copyWith(fontSize: fontSize),
          ),
        ));
  }
}

enum MuiButtonVariant {
  CONTAINED,
  LINK,
  LIGHT_LINK,
}

final contained = ContainedButtonStyles();
final link = LinkButtonStyles();
final light_link = LightLinkButtonStyles();

const _padding = EdgeInsets.symmetric(horizontal: 20, vertical: 8);
const _minimalPadding = EdgeInsets.symmetric(horizontal: 2, vertical: 2);
