import 'dart:math';

import 'package:egresadoapp/api/endpoints/api_auth.dart';
import 'package:egresadoapp/api/models/auth.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/footer/privacyfooter.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/button/muibutton.dart';
import '../../widgets/input/muiinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final _formKey;
  late AuthUser credentials;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    credentials =
        AuthUser(email: "rachel22@egresadoapp.com", password: "Rachel Perez");
    // credentials = AuthUser(email: "", password: "");
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        LoadingHandler.showLoading(context);
        User user = await ApiAuth.login(credentials);
        Provider.of<UsuarioProvider>(context, listen: false).set(user);
        Navigator.of(context).pushNamed(NavigatorRoutes.home);
      } catch (e) {
        LoadingHandler.hideLoading(context);
      }
    }
  }

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
                      child: AutofillGroup(
                        child: Form(
                          key: _formKey,
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
                                color: MuiInputColor.LIGHT,
                                finishAutofillContext: true,
                                autofillHints: const [AutofillHints.email],
                                label: "EMAIL",
                                onChanged: (p0) {
                                  credentials.email = p0 ?? "";
                                },
                                onFieldSubmitted: (_) {
                                  _handleLogin(context);
                                },
                                inputType: TextInputType.text,
                              ),
                              spacerS,
                              MuiInput(
                                color: MuiInputColor.LIGHT,
                                autofillHints: const [
                                  AutofillHints.password,
                                ],
                                finishAutofillContext: true,
                                label: "CONTRASEÑA",
                                onChanged: (p0) {
                                  credentials.password = p0 ?? "";
                                },
                                onFieldSubmitted: (_) {
                                  _handleLogin(context);
                                },
                                inputType: TextInputType.text,
                                hideInput: true,
                              ),
                              spacerXL,
                              MuiButton(
                                onPressed: () async {
                                  await _handleLogin(context);
                                },
                                text: "ENTRAR",
                                variant: MuiButtonVariant.CONTAINED,
                              ),
                              spacerXL,
                              MuiButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(Routes.register);
                                },
                                text: "¿Aún no tienes cuenta?",
                                variant: MuiButtonVariant.LIGHT_LINK,
                              ),
                              spacerS,
                            ],
                          ),
                        ),
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
