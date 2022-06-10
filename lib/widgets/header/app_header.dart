import 'package:egresadoapp/router/router.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class MuiAppHeader extends StatefulWidget {
  const MuiAppHeader({Key? key}) : super(key: key);

  @override
  State<MuiAppHeader> createState() => _MuiAppHeader();
}

class _MuiAppHeader extends State<MuiAppHeader> {
  @override
  Widget build(BuildContext context) {
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
      ],
    );
  }
}
