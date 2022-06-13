import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/spacer/spacer.dart';
import 'package:flutter/material.dart';

class MuiDatePicker extends StatelessWidget {
  String title;
  String helpText;
  int firstDate;
  int? initialDate;
  DateTime? lastDate;
  Function(DateTime) onPick;
  MuiDatePicker(
      {Key? key,
      required this.title,
      required this.helpText,
      required this.firstDate,
      this.lastDate,
      required this.onPick,
      this.initialDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () async {
          DateTime? picked = await showDatePicker(
              context: context,
              helpText: helpText,
              // initialDate: endDate == null
              //     ? DateTime.now()
              //     : DateTime
              //         .fromMillisecondsSinceEpoch(
              //             endDate),
              firstDate: DateTime.fromMillisecondsSinceEpoch(firstDate),
              lastDate: lastDate ?? DateTime.now(),
              initialDate: initialDate != null
                  ? DateTime.fromMillisecondsSinceEpoch(initialDate!)
                  : DateTime.now());
          if (picked != null) {
            onPick(picked);
          }
        },
        child: Padding(
          padding: insets,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.date_range,
                color: MuiPalette.BROWN,
              ),
              spacerS,
              Text(
                title,
                style: TextStyle(
                    color: MuiPalette.DARK_GREY, fontWeight: FontWeight.w600),
              )
            ],
          ),
        ),
      ),
    );
  }
}

const insets = EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 8);
