import 'package:egresadoapp/utils/dimensions.dart';
import 'package:flutter/material.dart';

import '../../utils/palette.dart';

class MuiSearchBar extends StatefulWidget {
  final Function(String) onSubmit;
  final Function(String) onType;
  final String? initialValue;
  const MuiSearchBar(
      {Key? key,
      required this.onSubmit,
      this.initialValue,
      required this.onType})
      : super(key: key);

  @override
  State<MuiSearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<MuiSearchBar> {
  TextEditingController controller = TextEditingController();
  bool showEx = false;
  @override
  void initState() {
    super.initState();
    controller.text = widget.initialValue ?? "";
    showEx = widget.initialValue != null && widget.initialValue != "";
    controller.addListener(() {
      if ((controller.text == "") == showEx) {
        setState(() {
          showEx = !showEx;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, right: 20),
      height: Dimensions.controllerHeight,
      constraints:
          BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
      width: 380,
      decoration: _decoration,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {
                widget.onSubmit(controller.text);
              },
              constraints: _constraints,
              iconSize: 24,
              padding: EdgeInsets.zero,
              icon: _searchIcon),
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextFormField(
                // initialValue: widget.initialValue,
                controller: controller,
                onFieldSubmitted: widget.onSubmit,
                textInputAction: TextInputAction.go,
                textAlignVertical: TextAlignVertical.center,
                autocorrect: false,
                onChanged: widget.onType,
                style: TextStyle(fontSize: Dimensions.labelFontSize + 2),
                // scrollPadding: EdgeInsets.all(4),
                // enabled: false,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  hintText: "Buscar",
                  hintStyle: TextStyle(color: MuiPalette.MID_GREY),
                  isCollapsed: true,
                  isDense: true,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 4),
                ),
                enableSuggestions: true,
                // onFieldSubmitted: widget.submitText,
              ),
            ),
          ),
          Visibility(
            visible: showEx,
            child: IconButton(
                onPressed: () {
                  // widget.onType("");
                  widget.onSubmit("");
                  controller.clear();
                },
                constraints: _constraints,
                padding: EdgeInsets.zero,
                icon: _closeIcon),
          ),
        ],
      ),
    );
  }
}

final _decoration =
    ShapeDecoration(color: MuiPalette.WHITE, shape: const StadiumBorder());
const _constraints = BoxConstraints(minWidth: 45, minHeight: 45);
final _searchIcon = Icon(
  Icons.search,
  size: 24,
  color: MuiPalette.BROWN,
);
final _closeIcon = Icon(
  Icons.close,
  size: 16,
  color: MuiPalette.BROWN,
);
