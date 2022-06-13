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
        var fechaInicio = provider.getFilters().fechaPublicacionInicio;
        var fechaFin = provider.getFilters().fechaPublicacionFin;

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
                MuiFilterDateMultipleExpansionTile(
                    fechaInicio: fechaInicio,
                    fechaFin: fechaFin,
                    onPickInicio: provider.setStartDate,
                    onPickFin: provider.setEndDate,
                    title: "Fecha de publicación"),
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
