import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/decorations.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/images/avatar_image.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/tupla/tupla.dart';
import 'package:flutter/material.dart';

class UsuarioCard extends StatelessWidget {
  final User usuario;
  const UsuarioCard({Key? key, required this.usuario}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MuiCard(
      onPress: () {
        Navigator.of(context)
            .pushNamed(NavigatorRoutes.userProfile(usuario.id));
      },
      width: userCardWidth,
      height: userCardHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.zero.copyWith(right: cardPadding.left),
            child: AvatarImage(
              url: usuario.avatar,
              customSize: 30,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                usuario.nombre,
                style: firstCellStyles,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: EstadoTag(estado: usuario.estado),
              ),
              Tupla(
                icon: Icons.email_outlined,
                text: usuario.email,
                textOverflow: TextOverflow.ellipsis,
                size: MuiTuplaSize.m,
              ),
              Tupla(
                icon: Icons.phone_rounded,
                textOverflow: TextOverflow.ellipsis,
                text: usuario.telefono ?? "-",
                size: MuiTuplaSize.m,
              )
            ],
          ))
        ],
      ),
    );
  }
}

const userCardWidth = 300.0;
const userCardHeight = 150.0;
const userCardAspectRatio = userCardWidth / userCardHeight;

final _userIcon = Padding(
  padding: EdgeInsets.zero.copyWith(right: cardPadding.left),
  child: Icon(
    Icons.account_circle,
    size: 30,
    color: MuiPalette.BROWN,
  ),
);

const _apellidosStyles = TextStyle(fontWeight: FontWeight.normal);

final _rolStyles = TextStyle(fontSize: Dimensions.cardTitleFontSize - 2);

final firstCellStyles = TextStyle(
    fontSize: Dimensions.cardTitleFontSize - 1,
    color: MuiPalette.BLACK,
    fontWeight: FontWeight.bold);
