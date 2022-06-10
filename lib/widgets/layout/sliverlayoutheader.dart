import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../spacer/spacer.dart';

class SliverLayoutHeader extends StatelessWidget {
  List<Widget> children;
  SliverLayoutHeader({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      actions: const [spacerZero],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      titleSpacing: 0,
      toolbarHeight: muiToolbarHeight,
      pinned: false,
      floating: true,
      snap: true,
      elevation: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(
                horizontal: Dimensions.pageInsetGap,
                vertical: Dimensions.pageInsetGap / 2)
            .copyWith(top: 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: children,
        ),
      ),
    );
  }
}

class SliverHeaderButton extends StatelessWidget {
  final Function() onPressed;
  final IconData icon;
  const SliverHeaderButton(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero.copyWith(
          left: Dimensions.pageInsetGap, right: Dimensions.pageInsetGap),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
      ),
    );
  }
}

final muiToolbarHeight =
    Dimensions.pageInsetGap * 2 + Dimensions.controllerHeight;
