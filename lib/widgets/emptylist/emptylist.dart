import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class EmptyList extends StatelessWidget {
  const EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No hay datos que mostrar",
        style: TextStyle(color: MuiPalette.BLACK, fontWeight: FontWeight.bold),
      ),
    );
  }
}
