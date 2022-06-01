import 'package:egresadoapp/router/router.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.userProfile);
                },
                child: const Text("MI PERFIL")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.users);
                },
                child: const Text("USUARIOS")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.offers);
                },
                child: const Text("OFERTAS")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.events);
                },
                child: const Text("EVENTOS")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.collaboration);
                },
                child: const Text("COLABORACIONES")),
          ],
        ),
      ),
    );
  }
}
