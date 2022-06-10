import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/providers/usuario_provider.dart';
import 'package:egresadoapp/widgets/filters/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UsuarioFilter extends StatelessWidget {
  const UsuarioFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UsuariosProvider>(
      builder: (context, provider, child) {
        var baseEstados = provider.getFilters().baseEstado;
        var estados = provider.getFilters().estados;
        var baseIdiomas = provider.getFilters().baseIdiomas;
        var idiomas = provider.getFilters().idiomas;
        var baseRoles = provider.getFilters().baseRoles;
        var roles = provider.getFilters().roles;
        var baseSkills = provider.getFilters().baseSkills;
        var skills = provider.getFilters().skills;

        return MuiFilterDrawer(
          subtitle: "Usuarios",
          onCleanFilter: () {
            provider.resetFilters().then((value) => null);
          },
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MuiFilterExpansionTile(
                  title: "Rol",
                  selected: roles,
                  available: baseRoles,
                  onPress: provider.toggleRol,
                  transformer: getLabelByRol,
                ),
                MuiFilterExpansionTile(
                  title: "Estado",
                  selected: estados,
                  available: baseEstados,
                  onPress: provider.toggleEstado,
                  transformer: getLabelByEstado,
                ),
                MuiFilterExpansionTile(
                  title: "Idioma",
                  selected: idiomas,
                  available: baseIdiomas,
                  onPress: provider.toggleIdiomas,
                ),
                MuiFilterExpansionTile(
                  title: "Skills",
                  selected: skills,
                  available: baseSkills,
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
