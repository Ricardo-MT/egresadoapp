import 'package:flutter/material.dart';

class MuiErrorWidget extends StatelessWidget {
  const MuiErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(Icons.error),
    );
  }
}
