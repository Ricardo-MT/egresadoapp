import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/utils/palette.dart';
import 'package:egresadoapp/widgets/button/muibutton.dart';
import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import 'filter_item.dart';

class MuiFilterDrawer extends StatelessWidget {
  final String subtitle;
  final VoidCallback onCleanFilter;
  final Widget child;
  const MuiFilterDrawer(
      {Key? key,
      this.subtitle = "",
      required this.onCleanFilter,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: filterInset,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        Text(
                          "Filtros",
                          style: _titleStyles,
                        ),
                        Text(subtitle, style: _subtitleStyles),
                      ])),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: filterInset.copyWith(top: 0),
                child: MuiButton(
                    onPressed: onCleanFilter,
                    variant: MuiButtonVariant.LINK,
                    text: "Limpiar filtros"),
              ),
            ),
            Expanded(child: child)
          ],
        ),
      ),
    );
  }
}

class MuiFilterExpansionTile extends StatelessWidget {
  String title;
  List<String> selected;
  List<String> available;
  Function(String) onPress;
  String Function(String)? transformer;
  MuiFilterExpansionTile(
      {Key? key,
      required this.available,
      required this.onPress,
      required this.selected,
      required this.title,
      this.transformer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      tilePadding: filterInsetHorizontal,
      title: Text(
        title,
        style: filterItemTitleStyle,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          selected.isEmpty
              ? ""
              : selected.length == 1
                  ? toCapitalCase(selected[0])
                  : toCapitalCase(selected[0]) + " (+${selected.length - 1})",
          style: filterItemSubtitleStyle,
        ),
      ),
      children: List.generate(available.length, (index) {
        var item = available[index];
        return FilterItem(
            marked: selected.contains(item),
            onPress: () {
              onPress(item);
            },
            title: transformer != null ? transformer!(item) : item);
      }),
    );
  }
}

final _titleStyles = TextStyle(
    fontSize: Dimensions.labelFontSize + 8,
    color: MuiPalette.DARK_GREY,
    fontWeight: FontWeight.bold);

final _subtitleStyles = TextStyle(
  fontSize: Dimensions.labelFontSize + 2,
  color: MuiPalette.MID_GREY,
);

final filterInset = EdgeInsets.all(Dimensions.pageInsetGap);
final filterInsetHorizontal =
    EdgeInsets.symmetric(horizontal: filterInset.right);

final filterItemTitleStyle = TextStyle(
    fontWeight: FontWeight.bold,
    color: MuiPalette.DARK_GREY,
    fontSize: Dimensions.cardTitleFontSize);
final filterItemSubtitleStyle = TextStyle(
    fontWeight: FontWeight.normal,
    color: MuiPalette.MID_GREY,
    fontSize: Dimensions.labelFontSize);
