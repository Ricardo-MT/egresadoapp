import 'package:egresadoapp/router/router.dart';
import 'package:flutter/material.dart';

class ColaboracionDetalle extends StatelessWidget {
  const ColaboracionDetalle({Key? key}) : super(key: key);

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
                  Navigator.of(context).pushNamed(Routes.collaborationEdit);
                },
                child: const Text("EDITAR")),
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
