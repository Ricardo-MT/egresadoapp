import 'package:egresadoapp/api/endpoints/api_auth.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/router/routes.dart';
import 'package:egresadoapp/widgets/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthCheckPage extends StatelessWidget {
  final bool shouldRedirect;
  const AuthCheckPage({Key? key, this.shouldRedirect = true}) : super(key: key);

  handleAuthCheck(BuildContext context) async {
    try {
      User user = await ApiAuth.checkUser();

      Provider.of<UsuarioProvider>(context, listen: false).set(user);
      if (shouldRedirect) {
        Navigator.of(context).pushNamed(NavigatorRoutes.home);
      }
    } catch (e) {
      if (shouldRedirect) {
        Navigator.of(context).pushNamed(NavigatorRoutes.home);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: handleAuthCheck(context),
        builder: ((context, snapshot) {
          return const LoadingPage();
        }));
  }
}
