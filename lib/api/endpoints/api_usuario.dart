import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/api/models/user.dart';

import 'api.dart';

class ApiUsuario {
  static Future<List<User>> fetchUsers(
      {String? searchText, required FiltroUsuarios filtros}) async {
    Map<String, dynamic> queryParameters = filtros.toJson();

    if (searchText != null) {
      queryParameters["searchText"] = searchText;
    }

    List<User> usuarios = [];

    dynamic res = await Api.GET_REQUEST(Api.USUARIOS, params: queryParameters);

    List<dynamic> fetched = res["usuarios"];
    for (var item in fetched) {
      try {
        usuarios.add(User.fromJson(item));
      } catch (e) {}
    }
    return usuarios;
  }

  static Future<User> fetchById(String id) async {
    dynamic res = await Api.GET_REQUEST(Api.USUARIOS + "/$id");
    return User.fromJson(res["usuario"]);
  }

  static Future<User> edit(User user) async {
    dynamic res = await Api.PUT_REQUEST(Api.USUARIOS, body: user.toJson());

    return User.fromJson(res["usuario"]);
  }
}
