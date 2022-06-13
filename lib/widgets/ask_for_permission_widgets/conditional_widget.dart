import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class MuiConditionalWidget extends StatelessWidget {
  Future<bool> permision;
  Widget child;
  bool maintainSpace;
  MuiConditionalWidget(
      {Key? key,
      required this.permision,
      this.maintainSpace = true,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: permision,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return maintainSpace
                ? spacerS
                : const Visibility(visible: true, child: spacerS);
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              (snapshot.data as bool) == false) {
            return maintainSpace
                ? spacerS
                : const Visibility(visible: false, child: spacerS);
          }
          return child;
        }));
  }
}
