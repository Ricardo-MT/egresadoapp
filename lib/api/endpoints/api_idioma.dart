import 'package:egresadoapp/api/models/idioma.dart';
import 'api.dart';

class ApiIdioma {
  static Future<List<String>> fetchIdiomas() async {
    List<String> idiomas = [];

    dynamic res = await Api.GET_REQUEST(Api.IDIOMAS);

    List<dynamic> fetched = res["idiomas"];
    for (var item in fetched) {
      idiomas.add(Idioma.fromJson(item).nombre);
    }
    return idiomas;
  }
}
