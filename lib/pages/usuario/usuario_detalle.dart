import 'package:flutter/material.dart';

import '../../router/router.dart';

class UsuarioDetalle extends StatelessWidget {
  const UsuarioDetalle({Key? key}) : super(key: key);

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
                  Navigator.of(context).pushNamed(Routes.userProfileEdit);
                },
                child: const Text("EDITAR MI PERFIL")),
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
