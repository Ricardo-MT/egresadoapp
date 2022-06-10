import 'package:egresadoapp/providers/eventos_provider.dart';
import 'package:egresadoapp/widgets/filters/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventosFilter extends StatelessWidget {
  const EventosFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EventosProvider>(
      builder: (context, provider, child) {
        var baseSkills = provider.getFilters().baseSkills;
        var skills = provider.getFilters().skills;

        return MuiFilterDrawer(
          subtitle: "Eventos",
          onCleanFilter: () {
            provider.resetFilters().then((value) => null);
          },
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
