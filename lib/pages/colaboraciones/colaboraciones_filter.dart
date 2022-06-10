import 'package:egresadoapp/providers/colaboraciones_provider.dart';
import 'package:egresadoapp/widgets/filters/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ColaboracionesFilter extends StatelessWidget {
  const ColaboracionesFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ColaboracionesProvider>(
      builder: (context, provider, child) {
        var baseSkillsRequeridos = provider.getFilters().baseSkillsRequeridos;
        var skillsRequeridos = provider.getFilters().skillsRequeridos;

        return MuiFilterDrawer(
          subtitle: "Colaboraciones",
          onCleanFilter: () {
            provider.resetFilters().then((value) => null);
          },
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MuiFilterExpansionTile(
                  title: "Skills requeridos",
                  selected: skillsRequeridos,
                  available: baseSkillsRequeridos,
                  onPress: provider.toggleSkill,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
