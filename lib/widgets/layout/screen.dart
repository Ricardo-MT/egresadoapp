import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/filters/filter_model.dart';
import 'package:egresadoapp/widgets/header/app_header.dart';
import 'package:egresadoapp/widgets/layout/navigation_drawer.dart';
import 'package:egresadoapp/widgets/muicard/muicard.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:egresadoapp/widgets/tap_to_hide_keyboard/tapToHideKeyboard.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MuiScreen extends StatefulWidget {
  Widget? child;
  MuiFilterModel? filter;
  MuiScreen({Key? key, this.child, this.filter}) : super(key: key);

  @override
  State<MuiScreen> createState() => _MuiScreenState();
}

class _MuiScreenState extends State<MuiScreen> {
  @override
  Widget build(BuildContext context) {
    return TapToHideKeyboard(
      child: Scaffold(
        key: widget.filter?.scaffoldKey,
        drawer: widget.filter?.child,
        resizeToAvoidBottomInset: true,
        endDrawerEnableOpenDragGesture: false,
        drawerEnableOpenDragGesture: false,
        endDrawer: const MuiNavigationDrawer(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: (!kIsWeb && Navigator.of(context).canPop())
              ? const BackButton()
              : null,
          title: const MuiAppHeader(),
          centerTitle: true,
          actions: MediaQuery.of(context).size.width < 700
              ? null
              : const [spacerZero],
        ),
        body: widget.child,
      ),
    );
  }
}

class MuiPageTitle extends StatelessWidget {
  final String label;
  const MuiPageTitle({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(label,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: MuiPalette.BLACK,
            fontSize: 20));
  }
}

class MuiDataScreen extends StatelessWidget {
  final String pageTitle;
  final Widget child;
  const MuiDataScreen({Key? key, required this.child, required this.pageTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.pageInsetGap),
        child: Center(
            child: Column(
          children: [
            MuiPageTitle(label: pageTitle),
            spacerS,
            MuiCard(
              width: 700,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 420),
                    child: child,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
