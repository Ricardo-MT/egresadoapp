import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/palette.dart';

final spinkit = SpinKitFadingCircle(
  color: MuiPalette.BROWN,
  size: 60.0,
);

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: spinkit,
    );
  }
}
