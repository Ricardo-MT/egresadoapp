import 'package:egresadoapp/api/models/skill.dart';
import 'api.dart';

class ApiSkills {
  static Future<List<String>> fetchSkills() async {
    List<String> skills = [];

    dynamic res = await Api.GET_REQUEST(Api.SKILLS);

    List<dynamic> fetched = res["skills"];
    for (var item in fetched) {
      skills.add(Skill.fromJson(item).nombre);
    }
    return skills;
  }
}
