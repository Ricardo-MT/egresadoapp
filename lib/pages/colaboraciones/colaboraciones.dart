import 'package:egresadoapp/router/router.dart';
import 'package:flutter/material.dart';

class ColaboracionesPage extends StatelessWidget {
  const ColaboracionesPage({Key? key}) : super(key: key);

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
                  Navigator.of(context).pushNamed(Routes.collaborationCreate);
                },
                child: const Text("Crear")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routes.collaborationDetail);
                },
                child: const Text("VER EN DETALLE")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("ATRÁS")),
          ],
        ),
      ),
    );
  }
}
