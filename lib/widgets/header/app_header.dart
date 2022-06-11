import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/logo/logo.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MuiAppHeader extends StatefulWidget {
  const MuiAppHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<MuiAppHeader> createState() => _MuiAppHeader();
}

class _MuiAppHeader extends State<MuiAppHeader> {
  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).size.width < 700) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            Navigator.of(context).pushNamed(NavigatorRoutes.home);
          },
          child: Logo(
            height: 40,
          ),
        ),
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          spacerExpanded,
          MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.home);
            },
            text: "Inicio",
            variant: MuiButtonVariant.LIGHT_LINK,
          ),
          MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.events);
            },
            text: "Eventos",
            variant: MuiButtonVariant.LIGHT_LINK,
          ),
          MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.collaboration);
            },
            text: "Colaboraciones",
            variant: MuiButtonVariant.LIGHT_LINK,
          ),
          MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.offers);
            },
            text: "Ofertas laborales",
            variant: MuiButtonVariant.LIGHT_LINK,
          ),
          MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.users);
            },
            text: "Usuarios",
            variant: MuiButtonVariant.LIGHT_LINK,
          ),
          spacerM,
          Consumer<UsuarioProvider>(
            builder: (context, provider, child) {
              return IconButton(
                  onPressed: () {
                    if (provider.user == null) {
                      Navigator.of(context).pushNamed(NavigatorRoutes.login);
                    } else {
                      Navigator.of(context).pushNamed(
                          NavigatorRoutes.userProfile(provider.user!.id));
                    }
                  },
                  icon: const Icon(Icons.person));
            },
          ),
        ],
      );
    }
  }
}
