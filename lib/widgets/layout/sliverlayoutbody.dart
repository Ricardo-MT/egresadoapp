import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/errorwidget/error_widget.dart';
import 'package:egresadoapp/widgets/layout/sliverlayoutbuilderforcards.dart';
import 'package:flutter/material.dart';

import '../loading/loading.dart';

class SliverLayoutBody extends StatelessWidget {
  Future<List<dynamic>>? future;
  List<Widget> Function(List<dynamic>) gridGenerator;
  double cardWidth;
  double cardAspectRatio;
  SliverLayoutBody({
    Key? key,
    required this.gridGenerator,
    required this.future,
    required this.cardWidth,
    required this.cardAspectRatio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: ((context, snapshot) {
          List<Widget> list = [const EmptyList()];
          if (snapshot.hasError) {
            list = [const MuiErrorWidget()];
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            list = [const Loading()];
          }
          if (snapshot.connectionState != ConnectionState.waiting &&
              snapshot.hasData &&
              (snapshot.data as List).isNotEmpty) {
            list = gridGenerator((snapshot.data as List));
          }

          return SliverLayoutBuilderForCards(
              cardWidth: cardWidth,
              cardAspectRatio: cardAspectRatio,
              list: list);
        }));
  }
}
