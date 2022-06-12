import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class MuiConditionalWidget extends StatelessWidget {
  Future<bool> permision;
  Widget child;
  MuiConditionalWidget({Key? key, required this.permision, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: permision,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return spacerS;
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              (snapshot.data as bool) == false) {
            return spacerS;
          }
          return child;
        }));
  }
}
