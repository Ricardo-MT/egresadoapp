import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/footer/privacyfooter.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

import '../../router/router.dart';
import '../../widgets/button/muibutton.dart';
import '../../widgets/input/muiinput.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/login.png"),
                    fit: BoxFit.cover)),
            child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/images/egresadologopng.png",
                    height: 140,
                  ),
                )),
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 320,
                    child: Column(
                      children: [
                        spacerXL,
                        Text(
                          "BIENVENID@",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              color: MuiPalette.FONT,
                              fontWeight: FontWeight.bold),
                        ),
                        spacerXL,
                        spacerXL,
                        MuiInput(
                          label: "EMAIL",
                          onChanged: (p0) {
                            // credentials.username = p0 ?? "";
                          },
                          onFieldSubmitted: (_) {
                            // handleLogin(context, userProvider);
                          },
                          inputType: TextInputType.text,
                        ),
                        spacerXL,
                        MuiInput(
                          label: "CONTRASEÑA",
                          onChanged: (p0) {
                            // credentials.username = p0 ?? "";
                          },
                          onFieldSubmitted: (_) {
                            // handleLogin(context, userProvider);
                          },
                          inputType: TextInputType.text,
                        ),
                        spacerXL,
                        MuiButton(
                          onPressed: () async {
                            // handleLogin(context, userProvider);
                          },
                          text: "ENTRAR",
                          variant: MuiButtonVariant.CONTAINED,
                        ),
                        spacerXL,
                        MuiButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(Routes.register);
                          },
                          text: "¿Aún no tienes cuenta?",
                          variant: MuiButtonVariant.LINK,
                        ),
                        spacerXL,
                      ],
                    ),
                  ),
                  const PrivacyFooter()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
