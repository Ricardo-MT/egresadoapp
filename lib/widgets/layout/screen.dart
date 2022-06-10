import 'package:egresadoapp/widgets/filters/filter_model.dart';
import 'package:egresadoapp/widgets/header/app_header.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
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
    return Scaffold(
      key: widget.filter?.scaffoldKey,
      drawer: widget.filter?.child,
      appBar: AppBar(
        automaticallyImplyLeading: !kIsWeb,
        title: const MuiAppHeader(),
        actions: const [spacerZero],
      ),
      body: widget.child,
    );
  }
}
