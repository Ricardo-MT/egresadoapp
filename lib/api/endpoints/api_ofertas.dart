import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/api/models/oferta.dart';
import 'package:egresadoapp/api/models/user.dart';

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

  static Future<User> edit(User user) async {
    dynamic res = await Api.PUT_REQUEST(Api.USUARIOS, body: user.toJson());

    return User.fromJson(res["usuario"]);
  }
}
