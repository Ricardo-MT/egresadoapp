import 'package:flutter/material.dart';

class MuiSpacer extends StatelessWidget {
  final double? height;
  const MuiSpacer({Key? key, this.height = 20}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: height,
    );
  }
}

const spacerZero = SizedBox(
  height: 0,
  width: 0,
);

const spacerExpanded = Expanded(child: spacerZero);

const spacerXs = SizedBox(
  height: 5,
  width: 5,
);

const spacerS = SizedBox(
  height: 12,
  width: 12,
);

const spacerM = SizedBox(
  height: 20,
  width: 20,
);

const spacerL = SizedBox(
  height: 30,
  width: 30,
);

const spacerXL = SizedBox(
  height: 40,
  width: 40,
);
