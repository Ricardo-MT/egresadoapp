import 'package:egresadoapp/api/endpoints/api_idioma.dart';
import 'package:egresadoapp/api/endpoints/api_skills.dart';
import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:egresadoapp/utils/debouncer.dart';
import 'package:flutter/material.dart';

class UsuariosProvider extends ChangeNotifier {
  String _search = "";
  late Key key;

  late FiltroUsuarios _filtro;

  UsuariosProvider() {
    key = UniqueKey();
    _filtro = _getDefaultFilter();
  }

  FiltroUsuarios _getDefaultFilter() {
    return FiltroUsuarios(
        baseEstado: [],
        estados: [],
        baseSkills: [],
        skills: [],
        baseIdiomas: [],
        idiomas: [],
        baseRoles: [],
        roles: []);
  }

  void refresh() {
    key = UniqueKey();
    notifyListeners();
  }

  void setSearch(String value) {
    _search = value;
    searchDebouncer.run(refresh);
  }

  String getSearch() => _search;

  Future<void> setFiltersAsyncronously() async {
    List<String> skills = [];
    List<String> idiomas = [];

    await Future.wait([
      ApiSkills.fetchSkills().then((lista) {
        skills = lista;
      }),
      ApiIdioma.fetchIdiomas().then((lista) {
        idiomas = lista;
      })
    ]);
    _filtro = FiltroUsuarios(
      baseEstado: Estados.values.map((e) => e.value).toList(),
      estados: _filtro.estados,
      baseIdiomas: idiomas,
      idiomas: _filtro.idiomas,
      baseRoles: Rol.values.map((e) => e.value).toList(),
      roles: _filtro.roles,
      baseSkills: skills,
      skills: _filtro.skills,
    );
  }

  Future<void> resetFilters() async {
    // _filtro = FiltroTiposProducto();
    _filtro = _getDefaultFilter();
    await setFiltersAsyncronously();
    refresh();
  }

  FiltroUsuarios getFilters() {
    return _filtro;
  }

  void toggleRol(String p) {
    int index = _filtro.roles.indexOf(p);
    if (index != -1) {
      _filtro.roles.removeWhere((element) => element == p);
    } else {
      _filtro.roles.add(p);
    }
    searchDebouncer.run(refresh);
  }

  void toggleEstado(String p) {
    int index = _filtro.estados.indexOf(p);
    if (index != -1) {
      _filtro.estados.removeWhere((element) => element == p);
    } else {
      _filtro.estados.add(p);
    }
    searchDebouncer.run(refresh);
  }

  void toggleIdiomas(String p) {
    int index = _filtro.idiomas.indexOf(p);
    if (index != -1) {
      _filtro.idiomas.removeWhere((element) => element == p);
    } else {
      _filtro.idiomas.add(p);
    }
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
