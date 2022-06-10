import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/widgets/filters/filter.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class FilterItem extends StatelessWidget {
  VoidCallback onPress;
  bool marked;
  String title;
  FilterItem(
      {Key? key,
      required this.marked,
      required this.onPress,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: _insets,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checked(checked: marked),
              spacerS,
              Text(
                toCapitalCase(title),
                style: TextStyle(
                    color: MuiPalette.DARK_GREY, fontWeight: FontWeight.normal),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Checked extends StatelessWidget {
  bool checked;
  Checked({Key? key, required this.checked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checked
        ? const Icon(
            Icons.radio_button_checked,
          )
        : const Icon(
            Icons.radio_button_off,
          );
  }
}

final _insets =
    EdgeInsets.symmetric(horizontal: filterInsetHorizontal.right, vertical: 12);
