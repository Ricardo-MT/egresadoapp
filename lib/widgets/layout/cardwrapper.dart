import 'package:egresadoapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class CardWrapper extends StatelessWidget {
  final Widget child;
  final int crossAxisCount;
  final int index;
  const CardWrapper(
      {Key? key,
      required this.child,
      required this.crossAxisCount,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      columnCount: crossAxisCount,
      position: index,
      duration: _animationDuration,
      child: ScaleAnimation(child: FadeInAnimation(child: child)),
    );
  }
}

final _animationDuration = Duration(milliseconds: Dimensions.animationDuration);
