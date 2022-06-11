import 'package:egresadoapp/api/models/user.dart';
import 'package:flutter/material.dart';

class UsuarioProvider extends ChangeNotifier {
  User? user;
  set(User? newUser) {
    user = newUser;
    notifyListeners();
  }

  remove() {
    user = null;
    notifyListeners();
  }
}
