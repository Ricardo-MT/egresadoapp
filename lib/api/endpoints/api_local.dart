import 'package:shared_preferences/shared_preferences.dart';

class ApiLocal {
  static Future<String?> getCookie() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? token = localStorage.getString("@token");
    return token;
  }

  static Future<void> setCookie(String token) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    await localStorage.setString("@token", token);
  }
}
