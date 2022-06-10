import 'dart:math';
import 'package:egresadoapp/widgets/layout/cardwrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../utils/dimensions.dart';

class SliverLayoutBuilderForCards extends StatelessWidget {
  double cardWidth;
  double cardAspectRatio;
  List<Widget> list;
  SliverLayoutBuilderForCards(
      {Key? key,
      required this.cardWidth,
      required this.cardAspectRatio,
      required this.list})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double itemExtent = (cardWidth + _gap * 2);
    int length = list.length;
    Key k = ValueKey(list.hashCode);

    return SliverLayoutBuilder(builder: ((context, constraints) {
      double crossAxisCountDouble =
          (constraints.crossAxisExtent - _gap) / itemExtent;
      int crossAxisCount = min(crossAxisCountDouble.toInt(), length);
      double p =
          (constraints.crossAxisExtent - itemExtent * crossAxisCount) / 2;

      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: p, vertical: _gap),
        sliver: AnimationLimiter(
          key: k,
          child: SliverGrid.count(
              mainAxisSpacing: _gap,
              crossAxisSpacing: _gap,
              crossAxisCount: crossAxisCount,
              childAspectRatio: cardAspectRatio,
              children: List.generate(
                  length,
                  (index) => Center(
                        child: CardWrapper(
                            crossAxisCount: crossAxisCount,
                            index: index,
                            child: list[index]),
                      ))),
        ),
      );
    }));
  }
}

final _gap = Dimensions.pageInsetGap - 10;
