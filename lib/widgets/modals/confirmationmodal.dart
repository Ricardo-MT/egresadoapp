import 'package:egresadoapp/providers/user_provider.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:egresadoapp/widgets/modals/basemodal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../spacer/spacer.dart';

class ConfirmationModal extends StatefulWidget {
  final String title;
  final String text;
  final AsyncCallback callback;
  const ConfirmationModal(
      {Key? key,
      required this.title,
      required this.text,
      required this.callback})
      : super(key: key);

  @override
  State<ConfirmationModal> createState() => _ConfirmationModalState();
}

class _ConfirmationModalState extends State<ConfirmationModal> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: MuiBaseModal(
          title: Text(widget.title),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                spacerXL,
                Text(
                  widget.text,
                  style: TextStyle(fontSize: 20, color: MuiPalette.DARK_GREY),
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
                      onPressed: () async {
                        try {
                          Provider.of<UsuarioProvider>(context, listen: false)
                              .set(null);
                          Navigator.of(context).pop(true);
                          await widget.callback();
                        } catch (e) {}
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
