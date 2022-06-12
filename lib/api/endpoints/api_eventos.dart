import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/api/models/filters.dart';

import 'api.dart';

class ApiEventos {
  static Future<List<Evento>> fetchEventos(
      {String? searchText, FiltroEventos? filtros}) async {
    Map<String, dynamic> queryParameters = {};

    if (filtros != null) {
      queryParameters.addAll(filtros.toJson());
    }

    if (searchText != null) {
      queryParameters["searchText"] = searchText;
    }

    List<Evento> eventos = [];

    dynamic res = await Api.GET_REQUEST(Api.EVENTOS, params: queryParameters);

    List<dynamic> fetched = res["eventos"];
    for (var item in fetched) {
      eventos.add(Evento.fromJson(item));
    }
    return eventos;
  }

  static Future<List<Evento>> fetchRecientes(
      {String? searchText, FiltroEventos? filtros}) async {
    List<Evento> eventos = [];

    dynamic res = await Api.GET_REQUEST(Api.EVENTOS + "/recientes");

    List<dynamic> fetched = res["eventos"];
    for (var item in fetched) {
      eventos.add(Evento.fromJson(item));
    }
    return eventos;
  }

  static Future<Evento> fetchById(String id) async {
    dynamic res = await Api.GET_REQUEST(Api.EVENTOS + "/$id");
    return Evento.fromJson(res["evento"]);
  }

  static Future<Evento> create(EventoCreating evento) async {
    dynamic res = await Api.POST_REQUEST(Api.EVENTOS, evento.toJson());

    return Evento.fromJson(res["evento"]);
  }

  static Future<Evento> edit(EventoEditing evento) async {
    dynamic res = await Api.PUT_REQUEST(Api.EVENTOS, body: evento.toJson());

    return Evento.fromJson(res["evento"]);
  }

  static Future<void> delete(Evento evento) =>
      Api.DELETE_REQUEST(Api.EVENTOS + "/${evento.id}");
}
