import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:flutter/material.dart';

enum MuiTuplaSize { s, m, l }

class Tupla extends StatelessWidget {
  final IconData icon;
  final String text;
  final MuiTuplaSize size;
  final bool bold;
  const Tupla(
      {Key? key,
      required this.icon,
      this.size = MuiTuplaSize.l,
      required this.text,
      this.bold = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconSize = 20;
    double fontSize = Dimensions.labelFontSize;
    switch (size) {
      case MuiTuplaSize.s:
        iconSize = 16;
        fontSize = 10;
        break;
      case MuiTuplaSize.m:
        iconSize = 20;
        fontSize = 12;
        break;
      default:
        iconSize = 28;
        fontSize = 14;
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: _padding,
          child: Icon(
            icon,
            size: iconSize,
            color: MuiPalette.BROWN,
          ),
        ),
        SelectableText(
          text,
          style: _textStyles.copyWith(
              fontSize: fontSize,
              fontWeight: bold ? FontWeight.bold : FontWeight.normal),
        )
      ],
    );
  }
}

final _textStyles = TextStyle(fontSize: 14, color: MuiPalette.DARK_GREY);
final _padding = EdgeInsets.only(right: Dimensions.cardSmallSpacing / 2);

class EstadoTag extends StatelessWidget {
  final String estado;
  const EstadoTag({Key? key, required this.estado}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: _padding,
          child: Icon(
            Icons.circle,
            size: 10,
            color: MuiPalette.GREEN,
          ),
        ),
        Text(
          getLabelByEstado(estado),
          style: _textStyles.copyWith(
              fontSize: Dimensions.labelFontSize, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

class RolTag extends StatelessWidget {
  final String rol;
  const RolTag({Key? key, required this.rol}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      getLabelByRol(rol),
      style: _textStyles.copyWith(
          fontSize: Dimensions.labelFontSize, fontWeight: FontWeight.bold),
    );
  }
}
