import 'package:egresadoapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ScaleInWrapper extends StatelessWidget {
  final Widget child;
  final int index;
  const ScaleInWrapper({Key? key, required this.child, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: _animationDuration,
      child: ScaleAnimation(child: child),
    );
  }
}

final _animationDuration = Duration(milliseconds: Dimensions.animationDuration);
