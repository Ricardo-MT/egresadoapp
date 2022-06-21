import 'package:egresadoapp/api/models/auth.dart';
import 'package:egresadoapp/api/models/filters.dart';
import 'package:egresadoapp/api/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import 'api.dart';

class ApiUsuario {
  static Future<List<User>> fetchUsers(
      {String? searchText,
      required FiltroUsuarios filtros,
      required int page}) async {
    Map<String, dynamic> queryParameters = {
      ...filtros.toJson(),
      "page": page.toString()
    };

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

  static Future<User> register(RegisterUser credentials) async {
    dynamic res = await Api.POST_REQUEST(Api.USUARIOS, {
      "email": credentials.email,
      "nombre": credentials.nombre,
      "password": credentials.password
    });

    return User.fromJson(res["usuario"]);
  }

  static Future<User> edit(User usuario, XFile? photo) async {
    String? url;
    if (photo != null) {
      url = await _uploadImage(usuario, photo);
    }
    usuario.avatar = url ?? usuario.avatar;
    dynamic res = await Api.PUT_REQUEST(Api.USUARIOS, body: usuario.toJson());
    return User.fromJson(res["usuario"]);
  }

  static Future<User> editRol(User user) async {
    dynamic res = await Api.PUT_REQUEST(Api.USUARIOS + "/editar_rol",
        body: {"_id": user.id, "rol": user.rol});
    return User.fromJson(res["usuario"]);
  }

  static Future<bool> canEditRol() async {
    dynamic res = await Api.GET_REQUEST(Api.USUARIOS + "/puede_editar_rol");
    return res["allowed"].runtimeType == bool && res["allowed"];
  }

  static Future<String> _uploadImage(User usuario, XFile photo) async {
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    final path = "files/images/avatars/${usuario.id}";
    final ref = storage.ref().child(path);

    await ref.putData(await photo.readAsBytes(),
        firebase_storage.SettableMetadata(contentType: photo.mimeType));
    String url = await ref.getDownloadURL();
    return url;
  }
}
