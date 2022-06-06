import 'package:egresadoapp/router/router.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:flutter/material.dart';

class PrivacyFooter extends StatelessWidget {
  const PrivacyFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.terms);
            },
            text: "Términos y condiciones",
            fontSize: 14,
            variant: MuiButtonVariant.LIGHT_LINK),
        MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.privacy);
            },
            text: "Política de privacidad",
            fontSize: 14,
            variant: MuiButtonVariant.LIGHT_LINK),
        MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.cookies);
            },
            text: "Cookies",
            fontSize: 14,
            variant: MuiButtonVariant.LIGHT_LINK),
      ],
    );
  }
}
