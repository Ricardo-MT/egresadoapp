import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuarioProvider>(
      builder: (context, provider, child) {
        User? usuario = provider.user;
        return Drawer(
          child: DecoratedBox(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/background.png"),
                    fit: BoxFit.cover)),
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
                            size: 80,
                          ),
                        ),
                        MuiButton(
                          onPressed: () {
                            if (usuario == null) {
                              Navigator.of(context)
                                  .pushNamed(NavigatorRoutes.login);
                            } else {
                              Navigator.of(context).pushNamed(
                                  NavigatorRoutes.userProfile(usuario.id));
                            }
                          },
                          text: usuario == null
                              ? "Inicia sesión"
                              : usuario.nombre.split(" ")[0],
                          variant: MuiButtonVariant.LIGHT_LINK,
                        )
                      ],
                    )),
                spacerM,
                MuiButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.home);
                  },
                  text: "Inicio",
                  fontSize: 24,
                  variant: MuiButtonVariant.LINK,
                ),
                MuiButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.events);
                  },
                  text: "Eventos",
                  fontSize: 24,
                  variant: MuiButtonVariant.LINK,
                ),
                MuiButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.collaboration);
                  },
                  text: "Colaboraciones",
                  fontSize: 24,
                  variant: MuiButtonVariant.LINK,
                ),
                MuiButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.offers);
                  },
                  text: "Ofertas laborales",
                  fontSize: 24,
                  variant: MuiButtonVariant.LINK,
                ),
                MuiButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.users);
                  },
                  text: "Usuarios",
                  fontSize: 24,
                  variant: MuiButtonVariant.LINK,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
