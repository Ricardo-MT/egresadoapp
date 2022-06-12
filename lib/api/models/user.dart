class User {
  String id;
  String email;
  String nombre;
  String? telefono;
  bool publico;
  String rol;
  String estado;
  String? descripcion;
  List<String> skills;
  List<String> idiomas;
  Map<String, String?>? socialLinks;
  User(
      {required this.id,
      required this.nombre,
      required this.email,
      this.telefono,
      required this.rol,
      required this.estado,
      required this.publico,
      this.descripcion,
      required this.skills,
      required this.idiomas,
      this.socialLinks});
  factory User.fromJson(Map<String, dynamic> map) {
    return User(
        id: map["_id"],
        nombre: map["nombre"],
        email: map["email"],
        telefono: map["telefono"],
        rol: map["rol"],
        estado: map["estado"],
        publico: map["publico"],
        descripcion: map["descripcion"],
        skills: ((map["skills"] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        idiomas: ((map["idiomas"] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        socialLinks: map["socialLinks"] != null
            ? Map<String, String?>.from(map["socialLinks"])
            : {});
  }
  factory User.fromCopy(User user) {
    return User(
        id: user.id,
        nombre: user.nombre,
        email: user.email,
        telefono: user.telefono,
        rol: user.rol,
        estado: user.estado,
        publico: user.publico,
        descripcion: user.descripcion,
        skills: user.skills.toList(),
        idiomas: user.idiomas.toList(),
        socialLinks: user.socialLinks);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "_id": id,
      "nombre": nombre,
      "email": email,
      "telefono": telefono,
      "rol": rol,
      "estado": estado,
      "publico": publico.toString(),
      "descripcion": descripcion,
      "skills": skills,
      "idiomas": idiomas,
      "socialLinks": socialLinks
    };
    return map;
  }
}

enum Rol { egresado, colaborador, admin }

enum Estados {
  desactivado,
  buscaTrabajo,
  buscaMejora,
  freelance,
  estudiante,
  trabajando,
  abiertoColaboraciones
}

const listaRoles = ["egresado", "colaborador", "admin"];

const listaEstados = [
  "desactivado",
  "buscaTrabajo",
  "buscaMejora",
  "freelance",
  "estudiante",
  "trabajando",
  "abiertoColaboraciones"
];

extension RolExtension on Rol {
  String get value {
    switch (this) {
      case Rol.egresado:
        return 'egresado';
      case Rol.colaborador:
        return 'colaborador';
      case Rol.admin:
        return 'admin';
      default:
        return "none";
    }
  }
}

String getLabelByRol(String rol) {
  print("LLEGA");
  print(rol);

  if (rol == Rol.egresado.value) {
    return "Egresad@";
  }
  if (rol == Rol.colaborador.value) {
    return "Colaborador";
  }
  if (rol == Rol.admin.value) {
    return "Administrador";
  }
  return "-";
}

extension EstadoExtension on Estados {
  String get value {
    switch (this) {
      case Estados.desactivado:
        return 'desactivado';
      case Estados.buscaTrabajo:
        return 'buscaTrabajo';
      case Estados.buscaMejora:
        return 'buscaMejora';
      case Estados.freelance:
        return 'freelance';
      case Estados.estudiante:
        return 'estudiante';
      case Estados.trabajando:
        return 'trabajando';
      case Estados.abiertoColaboraciones:
        return 'abiertoColaboraciones';
      default:
        return "none";
    }
  }
}

String getLabelByEstado(String estado) {
  if (estado == Estados.desactivado.value) {
    return "Desactivado";
  }
  if (estado == Estados.buscaTrabajo.value) {
    return "Busca trabajo";
  }
  if (estado == Estados.buscaMejora.value) {
    return "Busca mejora";
  }
  if (estado == Estados.freelance.value) {
    return "Freelance";
  }
  if (estado == Estados.estudiante.value) {
    return "Estudiante";
  }
  if (estado == Estados.trabajando.value) {
    return "Trabajando";
  }
  if (estado == Estados.abiertoColaboraciones.value) {
    return "Abierto a colaborar";
  }
  return "-";
}
