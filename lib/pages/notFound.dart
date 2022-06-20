import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  handleNavigation(BuildContext context) async {
    Navigator.of(context).pushReplacementNamed(NavigatorRoutes.authCheck);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "¡Ups!",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: MuiPalette.BROWN),
                ),
                Text(
                  "Esta página no existe",
                  style: TextStyle(fontSize: 40, color: MuiPalette.BROWN),
                ),
                spacerXL,
                MuiButton(
                  text: "Regresar a inicio",
                  variant: MuiButtonVariant.CONTAINED,
                  onPressed: () {
                    handleNavigation(context);
                  },
                )
              ],
            ),
            spacerL,
            const Icon(
              Icons.error_outline,
              size: 120,
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}
