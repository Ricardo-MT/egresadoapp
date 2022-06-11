import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: MuiPalette.BROWN,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Icon(
                      Icons.account_circle,
                      color: MuiPalette.WHITE,
                      size: 60,
                    ),
                  ),
                  MuiButton(
                    onPressed: () {},
                    text: "Tu usuario",
                    variant: MuiButtonVariant.LIGHT_LINK,
                  )
                ],
              )),
          spacerM,
          MuiButton(
            onPressed: () {},
            text: "Inicio",
            fontSize: 24,
            variant: MuiButtonVariant.LINK,
          ),
          MuiButton(
            onPressed: () {},
            text: "Eventos",
            fontSize: 24,
            variant: MuiButtonVariant.LINK,
          ),
          MuiButton(
            onPressed: () {},
            text: "Colaboraciones",
            fontSize: 24,
            variant: MuiButtonVariant.LINK,
          ),
          MuiButton(
            onPressed: () {},
            text: "Ofertas laborales",
            fontSize: 24,
            variant: MuiButtonVariant.LINK,
          ),
          MuiButton(
            onPressed: () {},
            text: "Usuarios",
            fontSize: 24,
            variant: MuiButtonVariant.LINK,
          )
        ],
      ),
    );
  }
}
