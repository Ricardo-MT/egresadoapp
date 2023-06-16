import 'package:egresadoapp/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

enum MuiIconVariant { discord, github, linkedin, telegram, twitter, whatsapp }

enum MuiIconColor { primary, accent, constrast, light, dark, transparent, none }

enum MuiIconSize { xs, s, m, l, xl }

Color? getColorFromProps(MuiIconColor color) {
  switch (color) {
    case MuiIconColor.primary:
      return MuiPalette.BROWN;
    case MuiIconColor.accent:
      return MuiPalette.BACKGROUND;
    case MuiIconColor.constrast:
      return MuiPalette.DARK_GREY;
    case MuiIconColor.dark:
      return MuiPalette.BLACK;
    case MuiIconColor.light:
      return MuiPalette.WHITE;
    case MuiIconColor.transparent:
      return Colors.transparent;
    default:
      return null;
  }
}

double _getSizeFromProps(MuiIconSize size) {
  switch (size) {
    case MuiIconSize.xs:
      return 10;
    case MuiIconSize.s:
      return 15;
    case MuiIconSize.m:
      return 24;
    case MuiIconSize.l:
      return 30;
    case MuiIconSize.xl:
      return 36;
    default:
      return 24;
  }
}

class MuiIcon extends StatelessWidget {
  final MuiIconVariant icon;
  final MuiIconColor color;
  final MuiIconSize size;
  final double? customSize;
  const MuiIcon(
      {Key? key,
      required this.icon,
      this.customSize,
      this.color = MuiIconColor.dark,
      this.size = MuiIconSize.m})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = customSize ?? _getSizeFromProps(size);

    return SvgPicture.asset("assets/icons/${icon.name}.svg",
        fit: BoxFit.contain,
        height: s,
        width: s,
        // currentColor: getColorFromProps(color),
        color: getColorFromProps(color));
  }
}
