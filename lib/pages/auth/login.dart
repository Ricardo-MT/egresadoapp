import 'dart:math';

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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/login.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                height: max(700, MediaQuery.of(context).size.height)),
            child: Padding(
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
                          spacerS,
                          Text(
                            "BIENVENID@",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                color: MuiPalette.WHITE,
                                fontWeight: FontWeight.bold),
                          ),
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
                          spacerS,
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
                              Navigator.of(context)
                                  .pushReplacementNamed(Routes.home);
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
                            variant: MuiButtonVariant.LIGHT_LINK,
                          ),
                          spacerS,
                        ],
                      ),
                    ),
                    const PrivacyFooter()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
