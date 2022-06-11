import 'package:egresadoapp/utils/decorations.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/styles/muibuttonstyles.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';

class MuiCard extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? width;
  final VoidCallback? onPress;
  const MuiCard(
      {Key? key, required this.child, this.height, this.onPress, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 4,
      shadowColor: Colors.black,
      shape: semiRoundedShape,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        hoverColor: Colors.transparent,
        onTap: onPress,
        child: SizedBox(
          height: height,
          width: width,
          child: Padding(
            padding: cardPadding,
            child: child,
          ),
        ),
      ),
    );
  }
}

class MuiDefaultCard extends StatelessWidget {
  final DefaultCardModel entidad;
  const MuiDefaultCard({Key? key, required this.entidad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MuiCard(
        onPress: entidad.onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entidad.titulo,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: defaultCardTitleStyle,
            ),
            spacerS,
            Expanded(
              child: Text(
                entidad.descripcion,
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
              ),
            ),
            spacerS,
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Tupla(
                      icon: Icons.person,
                      text: entidad.autor,
                      size: MuiTuplaSize.m,
                    ),
                    Tupla(
                      icon: Icons.calendar_today_rounded,
                      text: entidad.fecha,
                      size: MuiTuplaSize.m,
                    )
                  ],
                ),
                spacerExpanded,
                const Text("Ver detalles")
              ],
            )
          ],
        ),
        height: defaultCardHeight,
        width: defaultCardWidth);
  }
}

const defaultCardWidth = 340.0;
const defaultCardHeight = 200.0;
const defaultCardAspectRatio = defaultCardWidth / defaultCardHeight;

class DefaultCardModel {
  String titulo;
  String descripcion;
  String autor;
  String fecha;
  VoidCallback? onPress;
  DefaultCardModel(
      {required this.autor,
      required this.descripcion,
      required this.fecha,
      required this.titulo,
      this.onPress});
}

final defaultCardTitleStyle = TextStyle(
    fontSize: 18, color: MuiPalette.BROWN, fontWeight: FontWeight.bold);
