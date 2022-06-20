import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/images/avatar_image.dart';
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
          backgroundColor: MuiPalette.BROWN,
          child: SafeArea(
            bottom: false,
            child: DecoratedBox(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover)),
              child: ListView(
                children: [
                  SizedBox(
                    height: 200,
                    child: DrawerHeader(
                        decoration: BoxDecoration(
                          color: MuiPalette.BROWN,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Center(
                                child: AvatarImage(
                                  url: usuario?.avatar,
                                  withHero: true,
                                  customSize: 120,
                                ),
                              ),
                            ),
                            Center(
                              child: MuiButton(
                                onPressed: () {
                                  if (usuario == null) {
                                    Navigator.of(context)
                                        .pushNamed(NavigatorRoutes.login);
                                  } else {
                                    Navigator.of(context).pushNamed(
                                        NavigatorRoutes.userProfile(
                                            usuario.id));
                                  }
                                },
                                text: usuario == null
                                    ? "Inicia sesión"
                                    : usuario.nombre.split(" ")[0],
                                variant: MuiButtonVariant.LIGHT_LINK,
                              ),
                            )
                          ],
                        )),
                  ),
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
                  ),
                  MuiButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Routes.about);
                    },
                    text: "Conócenos",
                    fontSize: 24,
                    variant: MuiButtonVariant.LINK,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
