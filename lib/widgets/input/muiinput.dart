import 'package:flutter/material.dart';

import '../../utils/palette.dart';
import '../spacer/spacer.dart';
import 'styles/muiinputstyles.dart';

// ignore: constant_identifier_names
enum MuiInputVariant { OUTLINED, FILLED }
enum MuiInputColor { MAIN, LIGHT, DARK }

final outlinedStyles = OutLinedInputStyles();
final filledStyles = OutLinedInputStyles();

class MuiInput extends StatefulWidget {
  String label;
  bool hideInput;
  MuiInputVariant variant;
  MuiInputColor color;
  TextInputType inputType;
  VoidCallback? onPressed;
  Function(String?)? onChanged;
  Function(String?)? onFieldSubmitted;
  MuiInput(
      {Key? key,
      this.hideInput = false,
      this.onPressed,
      required this.label,
      this.onChanged,
      this.onFieldSubmitted,
      this.inputType = TextInputType.text,
      this.variant = MuiInputVariant.OUTLINED,
      this.color = MuiInputColor.MAIN})
      : super(key: key);

  @override
  State<MuiInput> createState() => _MuiInputState();
}

class _MuiInputState extends State<MuiInput> {
  late bool filled;
  late bool hideInput;

  @override
  void initState() {
    super.initState();
    filled = false;
    hideInput = widget.hideInput;
  }

  @override
  Widget build(BuildContext context) {
    MuiInputStyles style = outlinedStyles;
    Color _color = Colors.white;

    switch (widget.variant) {
      case MuiInputVariant.OUTLINED:
        style = outlinedStyles;
        break;
      case MuiInputVariant.FILLED:
        style = filledStyles;
        break;
      default:
    }
    switch (widget.color) {
      case MuiInputColor.MAIN:
        _color = MuiPalette.FONT;
        break;
      case MuiInputColor.LIGHT:
        _color = MuiPalette.BACKGROUND;
        break;
      case MuiInputColor.DARK:
        _color = MuiPalette.BLACK;
        break;
      default:
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(
              fontSize: 14,
              // letterSpacing: 1.2,
              fontWeight: FontWeight.bold,
              color: MuiPalette.FONT),
        ),
        spacerS,
        TextFormField(
          onFieldSubmitted: widget.onFieldSubmitted,
          style: TextStyle(
              color: MuiPalette.FONT,
              fontSize: 16,
              fontWeight: FontWeight.bold),
          autocorrect: false,
          cursorColor: MuiPalette.FONT,
          onChanged: (value) {
            if (filled != value.isNotEmpty) {
              setState(() {
                filled = value.isNotEmpty;
              });
            }

            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
          },
          keyboardType: widget.inputType,
          obscureText: hideInput,
          decoration: style.inputDecoration(context, filled, _color).copyWith(
                suffixIcon: widget.hideInput
                    ? MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTapDown: (details) {
                            if (hideInput) {
                              setState(() {
                                hideInput = false;
                              });
                            }
                          },
                          onTapUp: (details) {
                            if (!hideInput) {
                              setState(() {
                                hideInput = true;
                              });
                            }
                          },
                          child: Icon(
                            hideInput
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: hideInput
                                ? MuiPalette.DARK_GREY
                                : MuiPalette.RED,
                          ),
                        ),
                      )
                    : null,
              ),
        ),
      ],
    );
  }
}
