import 'package:egresadoapp/widgets/emptylist/emptylist.dart';
import 'package:egresadoapp/widgets/errorwidget/error_widget.dart';
import 'package:egresadoapp/widgets/layout/sliverlayoutbuilderforcards.dart';
import 'package:flutter/material.dart';

class SliverLayoutBody extends StatefulWidget {
  Future<List<dynamic>> Function(int) future;
  ScrollController controller;
  List<Widget> Function(List<dynamic>) gridGenerator;
  double cardWidth;
  double cardAspectRatio;
  SliverLayoutBody({
    Key? key,
    required this.controller,
    required this.gridGenerator,
    required this.future,
    required this.cardWidth,
    required this.cardAspectRatio,
  }) : super(key: key);

  @override
  State<SliverLayoutBody> createState() => _SliverLayoutBodyState();
}

class _SliverLayoutBodyState extends State<SliverLayoutBody> {
  late List<Widget> list;
  late int page;

  @override
  void initState() {
    super.initState();
    list = [];
    page = 1;
    _fetchPage(page);
    widget.controller.addListener(myListener);
  }

  myListener() {
    ScrollController c = widget.controller;
    if (c.positions.last.maxScrollExtent == c.offset) {
      _fetchPage(page + 1);
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await widget.future(pageKey);
      final isLastPage = newItems.isEmpty;
      if (!isLastPage) {
        page = pageKey;
        list.addAll(widget.gridGenerator(newItems));
        setState(() {});
      }
    } catch (error) {
      // _pagingController.error = error;

      list = [const MuiErrorWidget()];
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller.removeListener(myListener);
  }

  @override
  Widget build(BuildContext context) => SliverLayoutBuilderForCards(
      cardWidth: widget.cardWidth,
      cardAspectRatio: widget.cardAspectRatio,
      list: list.isEmpty ? const [EmptyList()] : list);
}
