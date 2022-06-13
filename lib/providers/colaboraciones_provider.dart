import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/utils/debouncer.dart';
import 'package:flutter/material.dart';

class ColaboracionesProvider extends ChangeNotifier {
  String _search = "";

  late FiltroColaboracion _filtro;

  ColaboracionesProvider() {
    _filtro = _getDefaultFilter();
  }

  FiltroColaboracion _getDefaultFilter() {
    return FiltroColaboracion(
      baseSkillsRequeridos: [],
      skillsRequeridos: [],
    );
  }

  void refresh() {
    notifyListeners();
  }

  void setSearch(String value) {
    _search = value;
    searchDebouncer.run(refresh);
  }

  String getSearch() => _search;

  Future<void> setFiltersAsyncronously() async {
    List<String> skills = [];

    await Future.wait([
      ApiSkills.fetchSkills().then((lista) {
        skills = lista;
      }),
    ]);
    _filtro = FiltroColaboracion(
        fechaPublicacionFin: _filtro.fechaPublicacionFin,
        fechaPublicacionInicio: _filtro.fechaPublicacionInicio,
        baseSkillsRequeridos: skills,
        skillsRequeridos: _filtro.skillsRequeridos);
  }

  Future<void> resetFilters() async {
    // _filtro = FiltroTiposProducto();
    _filtro = _getDefaultFilter();
    await setFiltersAsyncronously();
    refresh();
  }

  FiltroColaboracion getFilters() {
    return _filtro;
  }

  void setStartDate(DateTime t) async {
    int unix = t.millisecondsSinceEpoch;
    _filtro.fechaPublicacionInicio = unix;
    if (_filtro.fechaPublicacionFin != null &&
        _filtro.fechaPublicacionFin! < unix) {
      _filtro.fechaPublicacionFin = unix;
    }
    searchDebouncer.run(refresh);
  }

  Future<void> setEndDate(DateTime t) async {
    _filtro.fechaPublicacionFin = t.millisecondsSinceEpoch;
    searchDebouncer.run(refresh);
  }

  void toggleSkill(String p) {
    int index = _filtro.skillsRequeridos.indexOf(p);
    if (index != -1) {
      _filtro.skillsRequeridos.removeWhere((element) => element == p);
    } else {
      _filtro.skillsRequeridos.add(p);
    }
    searchDebouncer.run(refresh);
  }
}
