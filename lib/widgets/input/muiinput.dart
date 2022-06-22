import 'package:egresadoapp/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/palette.dart';
import '../spacer/spacer.dart';
import 'styles/muiinputstyles.dart';

// ignore: constant_identifier_names
enum MuiInputVariant { OUTLINED, FILLED }
enum MuiInputColor { MAIN, LIGHT, DARK }

final outlinedStyles = OutLinedInputStyles();
final filledStyles = OutLinedInputStyles();

class MuiInput extends StatefulWidget {
  TextEditingController? controller;
  String? initialValue;
  String label;
  bool hideInput;
  bool multiline;
  MuiInputVariant variant;
  MuiInputColor color;
  TextInputType inputType;
  VoidCallback? onPressed;
  Function(String?)? onChanged;
  Function(String?)? onFieldSubmitted;
  List<String>? autofillHints;
  String? Function(String?)? validator;
  bool finishAutofillContext;
  bool required;
  MuiInput(
      {Key? key,
      this.hideInput = false,
      this.multiline = false,
      this.onPressed,
      required this.label,
      this.required = false,
      this.onChanged,
      this.onFieldSubmitted,
      this.autofillHints,
      this.controller,
      this.validator,
      this.finishAutofillContext = false,
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
        Text.rich(
          TextSpan(
              text: widget.label,
              style: labelStyles.copyWith(color: _color),
              children: widget.required
                  ? [
                      const TextSpan(
                          text: " *", style: TextStyle(color: Colors.red))
                    ]
                  : []),
        ),
        // Text(
        //   widget.label,
        //   style: labelStyles.copyWith(color: _color),
        // ),
        spacerS,
        TextFormField(
          validator: widget.validator,
          controller: widget.controller,
          onEditingComplete: widget.finishAutofillContext
              ? () => TextInput.finishAutofillContext()
              : null,
          initialValue: widget.initialValue,
          onFieldSubmitted: widget.onFieldSubmitted,
          autofillHints: widget.autofillHints,
          style: inputFormFieldStyles,
          autocorrect: false,
          cursorColor: MuiPalette.FONT,
          maxLines: widget.multiline ? 10 : 1,
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

class MuiLabeledText extends StatelessWidget {
  final String label;
  final String text;
  final Widget? child;
  const MuiLabeledText(
      {Key? key, required this.label, required this.text, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyles,
        ),
        child == null
            ? SelectableText(text, style: inputFormFieldStyles)
            : child!
      ],
    );
  }
}

final labelStyles = TextStyle(
    fontSize: Dimensions.labelFontSize,
    fontWeight: FontWeight.bold,
    color: MuiPalette.BROWN);

final inputFormFieldStyles = TextStyle(
    color: MuiPalette.BLACK,
    fontSize: Dimensions.labelFontSize + 2,
    fontWeight: FontWeight.normal);
// TextStyle(
//               color: MuiPalette.FONT,
//               fontSize: 16,
//               fontWeight: FontWeight.bold)