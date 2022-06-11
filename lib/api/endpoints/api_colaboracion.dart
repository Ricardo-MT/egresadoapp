import 'package:egresadoapp/api/models/colaboracion.dart';
import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/api/models/user.dart';

import 'api.dart';

class ApiColaboracion {
  static Future<List<Colaboracion>> fetchColaboraciones(
      {String? searchText, FiltroColaboracion? filtros}) async {
    Map<String, dynamic> queryParameters = {};

    if (filtros != null) {
      queryParameters.addAll(filtros.toJson());
    }
    if (searchText != null) {
      queryParameters["searchText"] = searchText;
    }

    List<Colaboracion> colaboraciones = [];

    dynamic res =
        await Api.GET_REQUEST(Api.COLABORACIONES, params: queryParameters);

    List<dynamic> fetched = res["colaboraciones"];
    for (var item in fetched) {
      colaboraciones.add(Colaboracion.fromJson(item));
    }
    return colaboraciones;
  }

  static Future<List<Colaboracion>> fetchRecientes() async {
    List<Colaboracion> colaboraciones = [];

    dynamic res = await Api.GET_REQUEST(Api.COLABORACIONES + "/recientes");

    List<dynamic> fetched = res["colaboraciones"];
    for (var item in fetched) {
      colaboraciones.add(Colaboracion.fromJson(item));
    }
    return colaboraciones;
  }

  static Future<Colaboracion> fetchById(String id) async {
    dynamic res = await Api.GET_REQUEST(Api.COLABORACIONES + "/$id");
    return Colaboracion.fromJson(res["colaboracion"]);
  }

  static Future<User> edit(User user) async {
    dynamic res = await Api.PUT_REQUEST(Api.USUARIOS, body: user.toJson());

    return User.fromJson(res["usuario"]);
  }
}
