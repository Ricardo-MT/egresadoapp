import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../widgets/loading/loading.dart';
import 'dimensions.dart';
import 'palette.dart';

class LoadingHandler {
  static void showLoading(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        // barrierColor: Colors.amber,
        builder: (BuildContext context) {
          return const Loading();
        });
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static void showToast(BuildContext context, String message,
      {bool isError = true}) {
    showSimpleNotification(Text(message),
        contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.innerGap, vertical: Dimensions.innerGap / 2),
        duration: const Duration(seconds: 3),
        slideDismissDirection: DismissDirection.up,
        background: isError ? MuiPalette.RED : MuiPalette.GREEN);
  }
}
