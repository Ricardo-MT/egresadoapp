import 'dart:math';

import 'package:egresadoapp/utils/dimensions.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/modals/basemodal.dart';
import 'package:flutter/material.dart';

import '../spacer/spacer.dart';

class ConfirmationModal extends StatefulWidget {
  final String title;
  final String text;
  const ConfirmationModal({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  State<ConfirmationModal> createState() => _ConfirmationModalState();
}

class _ConfirmationModalState extends State<ConfirmationModal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: min(420, MediaQuery.of(context).size.width * 0.9)),
        child: MuiBaseModal(
          title: Text(
            widget.title,
            style: labelStyles.copyWith(fontSize: Dimensions.cardTitleFontSize),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spacerXL,
                Text(
                  widget.text,
                  style: labelStyles.copyWith(color: MuiPalette.DARK_GREY),
                  textAlign: TextAlign.center,
                ),
                spacerXL,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MuiButton(
                        variant: MuiButtonVariant.LINK,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: "Cancelar"),
                    spacerM,
                    MuiButton(
                      onPressed: () {
                        Navigator.of(context).pop(true);
                      },
                      text: "Confirmar",
                      variant: MuiButtonVariant.LINK,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
