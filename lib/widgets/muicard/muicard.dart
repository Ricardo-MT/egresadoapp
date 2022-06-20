import 'package:egresadoapp/api/models/user.dart';
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
            TuplaImage(
                url: entidad.autor.avatar,
                selectable: false,
                withHero: false,
                expandable: true,
                textOverflow: TextOverflow.ellipsis,
                text: entidad.autor.nombre),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Tupla(
                    icon: Icons.calendar_today_rounded,
                    text: entidad.fecha,
                    textOverflow: TextOverflow.ellipsis,
                    size: MuiTuplaSize.m,
                  ),
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
const defaultCardHeight = 210.0;
const defaultCardAspectRatio = defaultCardWidth / defaultCardHeight;

class DefaultCardModel {
  String titulo;
  String descripcion;
  User autor;
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
