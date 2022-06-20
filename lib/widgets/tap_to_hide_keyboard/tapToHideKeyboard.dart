import 'package:flutter/material.dart';

class TapToHideKeyboard extends StatelessWidget {
  final Widget child;
  const TapToHideKeyboard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // showLoading(context);
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: child,
    );
  }
}
