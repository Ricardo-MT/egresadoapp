import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/api/models/oferta.dart';

import 'api.dart';

class ApiOfertas {
  static Future<List<Oferta>> fetchOfertas(
      {String? searchText, FiltroOfertas? filtros}) async {
    Map<String, dynamic> queryParameters = {};
    if (filtros != null) {
      queryParameters.addAll(filtros.toJson());
    }
    if (searchText != null) {
      queryParameters["searchText"] = searchText;
    }

    List<Oferta> ofertas = [];

    dynamic res = await Api.GET_REQUEST(Api.OFERTAS, params: queryParameters);

    List<dynamic> fetched = res["ofertas"];
    for (var item in fetched) {
      ofertas.add(Oferta.fromJson(item));
    }
    return ofertas;
  }

  static Future<List<Oferta>> fetchRecientes(
      {String? searchText, FiltroOfertas? filtros}) async {
    List<Oferta> ofertas = [];

    dynamic res = await Api.GET_REQUEST(Api.OFERTAS + "/recientes");

    List<dynamic> fetched = res["ofertas"];
    for (var item in fetched) {
      ofertas.add(Oferta.fromJson(item));
    }
    return ofertas;
  }

  static Future<Oferta> fetchById(String id) async {
    dynamic res = await Api.GET_REQUEST(Api.OFERTAS + "/$id");
    return Oferta.fromJson(res["oferta"]);
  }

  static Future<Oferta> create(OfertaCreating oferta) async {
    dynamic res = await Api.POST_REQUEST(Api.OFERTAS, oferta.toJson());

    return Oferta.fromJson(res["oferta"]);
  }

  static Future<Oferta> edit(OfertaEditing oferta) async {
    dynamic res = await Api.PUT_REQUEST(Api.OFERTAS, body: oferta.toJson());

    return Oferta.fromJson(res["oferta"]);
  }

  static Future<void> delete(Oferta oferta) =>
      Api.DELETE_REQUEST(Api.OFERTAS + "/${oferta.id}");

  static Future<bool> canCreate() async {
    dynamic res = await Api.GET_REQUEST(Api.OFERTAS + "/puede_crear");
    return res["allowed"].runtimeType == bool && res["allowed"];
  }

  static Future<bool> canEdit() async {
    dynamic res = await Api.GET_REQUEST(Api.OFERTAS + "/puede_editar");
    return res["allowed"].runtimeType == bool && res["allowed"];
  }

  static Future<bool> canDelete() async {
    dynamic res = await Api.GET_REQUEST(Api.OFERTAS + "/puede_eliminar");
    return res["allowed"].runtimeType == bool && res["allowed"];
  }
}
