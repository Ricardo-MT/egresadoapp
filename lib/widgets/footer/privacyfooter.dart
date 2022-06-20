import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/logo/logo.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
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
            text: "Términos",
            fontSize: Dimensions.labelFontSize,
            variant: MuiButtonVariant.LIGHT_LINK),
        MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.privacy);
            },
            text: "Política de privacidad",
            fontSize: Dimensions.labelFontSize,
            variant: MuiButtonVariant.LIGHT_LINK),
        MuiButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.cookies);
            },
            text: "Cookies",
            fontSize: Dimensions.labelFontSize,
            variant: MuiButtonVariant.LIGHT_LINK),
      ],
    );
  }
}

class FullFooter extends StatelessWidget {
  const FullFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Container(
        width: double.infinity,
        color: MuiPalette.BROWN,
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Logo(
              height: 50,
            ),
            spacerS,
            const PrivacyFooter(),
          ],
        ),
      ),
    );
  }
}
