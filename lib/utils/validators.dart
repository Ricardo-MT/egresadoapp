// ignore: import_of_legacy_library_into_null_safe
import 'package:email_validator/email_validator.dart';

class Validators {
  static String? validateEmail(String? email) {
    if (email != null && !EmailValidator.validate(email)) {
      return "Email no válido.";
    }
    return null;
  }

  static String? validateIsEmpty(String? pass) {
    if (pass != null && pass.isEmpty) {
      return "Introduce un valor.";
    }
    return null;
  }

  static String validatePassword(String pass) {
    if (pass.isEmpty) {
      return "Introduce un valor.";
    }
    if (pass.length < 3) {
      return "El campo no debe tener menos de 3 caracteres.";
    }
    if (pass.length > 10) {
      return "El campo no debe tener más de 10 caracteres.";
    }
    return "";
  }

  static NullableStringFunction validateRepeatedPassword(String? pass) =>
      (String? value) => avalidateRepeatedPassword(value, pass);

  static String? avalidateRepeatedPassword(String? original, String? pass) {
    if (original!.isEmpty || pass!.isEmpty) {
      return "Introduce un valor.";
    }
    if (original != pass) {
      return "Las contraseñas deben coincidir.";
    }
    return null;
  }
}

typedef NullableStringFunction = String? Function(String?);
