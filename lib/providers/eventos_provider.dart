import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/utils/debouncer.dart';
import 'package:flutter/material.dart';

class EventosProvider extends ChangeNotifier {
  String _search = "";

  late FiltroEventos _filtro;

  EventosProvider() {
    _filtro = _getDefaultFilter();
  }

  FiltroEventos _getDefaultFilter() {
    return FiltroEventos(
      baseSkills: [],
      skills: [],
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
    _filtro = FiltroEventos(
        fechaFin: _filtro.fechaFin,
        fechaInicio: _filtro.fechaInicio,
        baseSkills: skills,
        skills: _filtro.skills);
  }

  Future<void> resetFilters() async {
    // _filtro = FiltroTiposProducto();
    _filtro = _getDefaultFilter();
    await setFiltersAsyncronously();
    refresh();
  }

  FiltroEventos getFilters() {
    return _filtro;
  }

  void setStartDate(DateTime t) async {
    int unix = t.millisecondsSinceEpoch;
    _filtro.fechaInicio = unix;
    if (_filtro.fechaFin != null && _filtro.fechaFin! < unix) {
      _filtro.fechaFin = unix;
    }
    searchDebouncer.run(refresh);
  }

  Future<void> setEndDate(DateTime t) async {
    _filtro.fechaFin = t.millisecondsSinceEpoch;
    searchDebouncer.run(refresh);
  }

  void toggleSkill(String p) {
    int index = _filtro.skills.indexOf(p);
    if (index != -1) {
      _filtro.skills.removeWhere((element) => element == p);
    } else {
      _filtro.skills.add(p);
    }
    searchDebouncer.run(refresh);
  }
}
