import 'dart:math';

import 'package:flutter/material.dart';

import '../../router/router.dart';
import '../../utils/palette.dart';
import '../../widgets/button/muibutton.dart';
import '../../widgets/footer/privacyfooter.dart';
import '../../widgets/input/muiinput.dart';
import '../../widgets/spacer/spacer.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/register.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
                height: max(700, MediaQuery.of(context).size.height)),
            child: SizedBox(
              width: 500,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
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
                            "ÚNETE A LA COMUNIDAD",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 35,
                                color: MuiPalette.WHITE,
                                fontWeight: FontWeight.bold),
                          ),
                          spacerXL,
                          MuiInput(
                            label: "NOMBRE",
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
                          spacerS,
                          MuiInput(
                            label: "CONFIRMA TU CONTRASEÑA",
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
                            text: "REGÍSTRATE",
                            variant: MuiButtonVariant.CONTAINED,
                          ),
                          spacerXL,
                          MuiButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(Routes.login);
                            },
                            text: "¿Ya tienes cuenta?",
                            variant: MuiButtonVariant.LIGHT_LINK,
                          ),
                          spacerS,
                        ],
                      ),
                    ),
                    const Center(child: PrivacyFooter())
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
