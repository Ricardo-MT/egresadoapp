import 'package:egresadoapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';

import '../widgets/loading/loading.dart';
import 'palette.dart';

class LoadingHandler {
  static void showLoading(BuildContext context, [bool light = false]) {
    showDialog(
        barrierDismissible: false,
        context: context,
        barrierColor: light ? Colors.black12 : Colors.black54,
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
            horizontal: Dimensions.innerGap * 2,
            vertical: Dimensions.innerGap / 2),
        duration: const Duration(seconds: 4),
        slideDismissDirection: DismissDirection.up,
        background: isError ? MuiPalette.RED : MuiPalette.GREEN);
  }

  static void showToastWithoutContext(String message, {bool isError = true}) {
    showSimpleNotification(Text(message),
        contentPadding: EdgeInsets.symmetric(
            horizontal: Dimensions.innerGap * 2,
            vertical: Dimensions.innerGap / 2),
        duration: const Duration(seconds: 4),
        slideDismissDirection: DismissDirection.up,
        background: isError ? MuiPalette.RED : MuiPalette.GREEN);
  }
}
