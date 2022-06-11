import 'package:flutter/material.dart';

class MuiTouchable extends StatelessWidget {
  final Widget child;
  final Function() onPress;
  const MuiTouchable({Key? key, required this.child, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        child: child,
      ),
    );
  }
}
