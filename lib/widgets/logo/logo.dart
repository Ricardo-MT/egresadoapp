import 'package:flutter/material.dart';

enum LogoVariant { original, white, red }

class Logo extends StatelessWidget {
  Color? color;
  double? height;
  LogoVariant? variant;
  BoxFit fit;
  AlignmentGeometry alignment;
  Logo(
      {Key? key,
      this.color,
      this.height,
      this.fit = BoxFit.contain,
      this.alignment = Alignment.center,
      this.variant = LogoVariant.original})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String path = "assets/images/logo.png";
    // switch (variant) {
    //   case LogoVariant.white:
    //     path = "assets/svg/logo_white.svg";
    //     break;
    //   case LogoVariant.red:
    //     path = "assets/svg/logo_red.svg";
    //     break;
    //   default:
    //     path = "assets/svg/logo_original.svg";
    //     break;
    // }
    return Image.asset(
      path,
      fit: fit,
      alignment: alignment,
      height: height,
      semanticLabel: "Logo",
    );
    // return SvgPicture.asset(
    //   path,
    //   fit: fit,
    //   alignment: alignment,
    //   color: color,
    //   height: height,
    //   semanticsLabel: 'Logo',
    // );
  }
}
