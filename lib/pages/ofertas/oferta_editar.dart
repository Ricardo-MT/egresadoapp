import 'package:flutter/material.dart';

class OfertaEditar extends StatelessWidget {
  const OfertaEditar({Key? key}) : super(key: key);

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
                  Navigator.of(context).pop();
                },
                child: const Text("ATRÁS")),
          ],
        ),
      ),
    );
  }
}
