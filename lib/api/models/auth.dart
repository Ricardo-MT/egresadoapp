class AuthUser {
  String email;
  String password;
  AuthUser({this.email = "", this.password = ""});
}

class RegisterUser {
  String? nombre;
  String? email;
  String? password;
  String? repeatPassword;
  RegisterUser({this.nombre, this.password, this.email, this.repeatPassword});
}

class NewPass {
  String newPass = "";
  String repeatPass = "";
  NewPass();
}
