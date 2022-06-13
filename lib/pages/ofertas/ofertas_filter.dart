import 'package:egresadoapp/providers/ofertas_provider.dart';
import 'package:egresadoapp/utils/converters.dart';
import 'package:egresadoapp/widgets/filters/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OfertasFilter extends StatelessWidget {
  const OfertasFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<OfertasProvider>(
      builder: (context, provider, child) {
        var basePresencialidad = provider.getFilters().basePresencialidad;
        var presencialidad = provider.getFilters().presencialidad;
        var baseSkillsRequeridos = provider.getFilters().baseSkillsRequeridos;
        var skillsRequeridos = provider.getFilters().skillsRequeridos;
        var baseTipoJornada = provider.getFilters().baseTipoJornada;
        var tipoJornada = provider.getFilters().tipoJornada;
        var fechaInicio = provider.getFilters().fechaPublicacionInicio;
        var fechaFin = provider.getFilters().fechaPublicacionFin;

        return MuiFilterDrawer(
          subtitle: "Ofertas laborales",
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
                  title: "Tipo de jornada",
                  selected: tipoJornada,
                  available: baseTipoJornada,
                  onPress: provider.toggleTipoJornada,
                  transformer: toCapitalCase,
                ),
                MuiFilterExpansionTile(
                  title: "Presencialidad",
                  selected: presencialidad,
                  available: basePresencialidad,
                  onPress: provider.togglePresencialidad,
                  transformer: toCapitalCase,
                ),
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
