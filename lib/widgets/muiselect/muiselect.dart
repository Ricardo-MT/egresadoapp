import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/widgets/input/muiinput.dart';
import 'package:egresadoapp/widgets/skills/skill_tag.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../utils/palette.dart';
import '../spacer/spacer.dart';

class MuiSelect extends StatelessWidget {
  final String label;
  String? value;
  String hint;
  List<String> values;
  String? Function(String?)? validator;
  String Function(String)? transformer;
  Function(String?)? onChanged;
  bool required;
  MuiSelect(
      {Key? key,
      required this.label,
      required this.value,
      required this.hint,
      this.validator,
      this.required = false,
      this.transformer,
      required this.onChanged,
      required this.values})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: label,
              style: labelStyles,
              children: required
                  ? [
                      TextSpan(
                          text: " *", style: TextStyle(color: MuiPalette.RED))
                    ]
                  : []),
        ),
        spacerS,
        DropdownButtonFormField<String>(
            elevation: 4,
            validator: validator,
            isExpanded: true,
            decoration:
                outlinedStyles.inputDecoration(context, true, MuiPalette.BLACK),
            icon: _iconWidget,
            value: value,
            hint: Text(
              hint,
              style: _hintStyles,
            ),
            items: List.generate(values.length, (index) {
              String val = values[index];
              return DropdownMenuItem(
                  value: val,
                  child: Text(
                    toCapitalCase(
                        transformer != null ? transformer!(val) : val),
                    style: inputFormFieldStyles,
                  ));
            }),
            onChanged: onChanged)
      ],
    );
  }
}

class MuiSelectMultiple extends StatelessWidget {
  final String label;
  List<String>? values;
  String hint;
  List<String> options;
  String? Function(String?)? validator;
  Function(List<String>?)? onChanged;
  bool required;
  MuiSelectMultiple(
      {Key? key,
      required this.label,
      required this.values,
      required this.hint,
      this.validator,
      this.required = false,
      required this.onChanged,
      required this.options})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
              text: label,
              style: labelStyles,
              children: required
                  ? [
                      TextSpan(
                          text: " *", style: TextStyle(color: MuiPalette.RED))
                    ]
                  : []),
        ),
        spacerS,
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              await showDialog(
                context: context,
                builder: (ctx) {
                  return MultiSelectDialog(
                    title: Text(
                      label,
                      style: labelStyles,
                    ),
                    cancelText: const Text("CANCELAR"),
                    selectedColor: MuiPalette.RED,
                    width: 400,
                    height: 600,
                    items: [
                      for (var i = 0; i < options.length; i++)
                        MultiSelectItem(options[i], options[i])
                    ],
                    itemsTextStyle: inputFormFieldStyles,
                    selectedItemsTextStyle: inputFormFieldStyles,
                    initialValue: values ?? [],
                    onConfirm: (values) {
                      onChanged?.call([
                        for (var i = 0; i < values.length; i++)
                          values[i].toString()
                      ]);
                    },
                  );
                },
              );
            },
            child: AbsorbPointer(
              child: TextFormField(
                key: ValueKey(values.hashCode),
                initialValue: (values ?? []).join(", "),
                readOnly: true,
                showCursor: false,
                validator: (val) {
                  return validator?.call((values ?? []).join(", "));
                },
                style: inputFormFieldStyles,
                cursorColor: MuiPalette.BLACK,
                decoration: outlinedStyles
                    .inputDecoration(context, true, MuiPalette.RED)
                    .copyWith(
                      hintText: hint,
                      hintStyle: _hintStyles,
                      suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: _iconWidget),
                    ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class MuiSelectTags extends StatelessWidget {
  final String label;
  List<String> list;
  List<String> selected;
  Function(List<String>) onConfirm;
  MuiSelectTags(
      {Key? key,
      required this.label,
      required this.onConfirm,
      required this.list,
      required this.selected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MultiSelectDialogField(
          buttonText: Text(
            label,
            style: labelStyles.copyWith(color: MuiPalette.BLACK),
          ),
          chipDisplay: MultiSelectChipDisplay.none(),
          buttonIcon: const Icon(Icons.keyboard_arrow_down_rounded),
          cancelText: Text(
            "Cancelar",
            style:
                TextStyle(color: MuiPalette.BLACK, fontWeight: FontWeight.bold),
          ),
          confirmText: Text(
            "Aceptar",
            style:
                TextStyle(color: MuiPalette.BLACK, fontWeight: FontWeight.bold),
          ),
          title: Text(
            label,
            style: labelStyles.copyWith(color: MuiPalette.BLACK),
          ),
          items: list.map((e) => MultiSelectItem(e, e)).toList(),
          selectedItemsTextStyle: const TextStyle(color: Colors.white),
          listType: MultiSelectListType.CHIP,
          initialValue: selected,
          onConfirm: (values) {
            onConfirm(values.map((e) => e.toString()).toList());
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Wrap(
              alignment: WrapAlignment.start,
              spacing: 20,
              runSpacing: 10,
              children: [
                for (var i = 0; i < selected.length; i++)
                  SkillTag(
                    skill: selected[i],
                  )
              ]),
        )
      ],
    );
    // return Column(
    //     mainAxisSize: MainAxisSize.min,
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(children: [
    //         Expanded(
    //           child: Text(
    //             label,
    //             style: labelStyles,
    //           ),
    //         ),
    //         IconButton(onPressed: () {}, icon: const Icon(Icons.edit))
    //       ]),
    //       Wrap(spacing: 20, children: [
    //         for (var i = 0; i < list.length; i++)
    //           SkillTag(
    //             skill: list[i],
    //             showIcon: true,
    //             onPress: () {},
    //           )
    //       ])
    //     ]);
  }
}

const _iconSize = 20.0;

final _iconWidget = Icon(
  Icons.keyboard_arrow_down_rounded,
  size: _iconSize,
  color: MuiPalette.BLACK,
);
final _hintStyles = inputFormFieldStyles.copyWith(color: MuiPalette.MID_GREY);
