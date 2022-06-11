import '../models/auth.dart';
import '../models/user.dart';
import 'api.dart';

class ApiAuth {
  static Future<User> login(AuthUser credentials) async {
    dynamic res = await Api.POST_REQUEST(Api.AUTH,
        {"email": credentials.email, "password": credentials.password});

    return User.fromJson(res["usuario"]);
  }

  static Future<void> logout() async {
    await Api.DELETE_REQUEST(Api.AUTH);
  }

  static Future<User> checkUser() async {
    dynamic res = await Api.GET_REQUEST(Api.AUTH);
    return User.fromJson(res["usuario"]);
  }
}
