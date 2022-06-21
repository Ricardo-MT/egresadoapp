import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/api/models/filters.dart';

import 'api.dart';

class ApiEventos {
  static Future<List<Evento>> fetchEventos(
      {String? searchText, FiltroEventos? filtros, required int page}) async {
    Map<String, dynamic> queryParameters = {"page": page.toString()};

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

  static Future<bool> canCreate() async {
    dynamic res = await Api.GET_REQUEST(Api.EVENTOS + "/puede_crear");
    return res["allowed"].runtimeType == bool && res["allowed"];
  }

  static Future<bool> canEdit() async {
    dynamic res = await Api.GET_REQUEST(Api.EVENTOS + "/puede_editar");
    return res["allowed"].runtimeType == bool && res["allowed"];
  }

  static Future<bool> canDelete() async {
    dynamic res = await Api.GET_REQUEST(Api.EVENTOS + "/puede_eliminar");
    return res["allowed"].runtimeType == bool && res["allowed"];
  }

  static Future<void> showInterest(Evento evento) async {
    await Api.POST_REQUEST(Api.EVENTOS + "/mostrarInteres/${evento.id}");
  }
}
