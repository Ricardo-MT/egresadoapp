import 'dart:math';

import 'package:egresadoapp/api/endpoints/api_usuario.dart';
import 'package:egresadoapp/api/models/auth.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/utils/loading.dart';
import 'package:egresadoapp/utils/validators.dart';
import 'package:egresadoapp/widgets/tap_to_hide_keyboard/tapToHideKeyboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/palette.dart';
import '../../widgets/button/muibutton.dart';
import '../../widgets/footer/privacyfooter.dart';
import '../../widgets/input/muiinput.dart';
import '../../widgets/spacer/spacer.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late final _formKey;
  late RegisterUser credentials;

  @override
  void initState() {
    super.initState();
    credentials = RegisterUser();
    _formKey = GlobalKey<FormState>();
  }

  Future<void> _handleRegister(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        LoadingHandler.showLoading(context);
        User user = await ApiUsuario.register(credentials);
        Provider.of<UsuarioProvider>(context, listen: false).set(user);
        Navigator.of(context).pushReplacementNamed(Routes.userProfileEdit);
      } catch (e) {
        LoadingHandler.hideLoading(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TapToHideKeyboard(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            height: max(MediaQuery.of(context).size.height, 820),
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/register.png"),
                    fit: BoxFit.cover)),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: min(MediaQuery.of(context).size.width - 40, 320),
                      child: AutofillGroup(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              spacerS,
                              Text(
                                "ÚNETE A LA COMUNIDAD",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: MuiPalette.WHITE,
                                    fontWeight: FontWeight.bold),
                              ),
                              spacerXL,
                              MuiInput(
                                required: true,
                                color: MuiInputColor.LIGHT,
                                validator: Validators.validateIsEmpty,
                                autofillHints: const [AutofillHints.name],
                                label: "NOMBRE",
                                onChanged: (p0) {
                                  credentials.nombre = p0 ?? "";
                                  setState(() {});
                                },
                                inputType: TextInputType.text,
                              ),
                              MuiInput(
                                required: true,
                                color: MuiInputColor.LIGHT,
                                autofillHints: const [AutofillHints.email],
                                label: "EMAIL",
                                validator: Validators.validateEmail,
                                onChanged: (p0) {
                                  credentials.email = p0 ?? "";
                                  setState(() {});
                                },
                                inputType: TextInputType.text,
                              ),
                              MuiInput(
                                required: true,
                                color: MuiInputColor.LIGHT,
                                label: "CONTRASEÑA",
                                autofillHints: const [
                                  AutofillHints.newPassword
                                ],
                                validator: Validators.validatePassword,
                                onChanged: (p0) {
                                  credentials.password = p0 ?? "";
                                  setState(() {});
                                },
                                inputType: TextInputType.text,
                              ),
                              MuiInput(
                                color: MuiInputColor.LIGHT,
                                required: true,
                                label: "CONFIRMA TU CONTRASEÑA",
                                validator: Validators.validateRepeatedPassword(
                                    credentials.password),
                                onChanged: (p0) {
                                  credentials.repeatPassword = p0 ?? "";
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) {
                                  _handleRegister(context);
                                },
                                inputType: TextInputType.text,
                              ),
                              spacerM,
                              MuiButton(
                                onPressed: () async {
                                  _handleRegister(context);
                                },
                                text: "REGÍSTRATE",
                                variant: MuiButtonVariant.CONTAINED,
                              ),
                              spacerM,
                              MuiButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(Routes.login);
                                },
                                text: "¿Ya tienes cuenta?",
                                variant: MuiButtonVariant.LIGHT_LINK,
                              ),
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
