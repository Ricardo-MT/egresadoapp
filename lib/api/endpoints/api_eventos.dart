import 'package:egresadoapp/api/models/evento.dart';
import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/api/models/user.dart';

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

  static Future<User> edit(User user) async {
    dynamic res = await Api.PUT_REQUEST(Api.USUARIOS, body: user.toJson());

    return User.fromJson(res["usuario"]);
  }
}
