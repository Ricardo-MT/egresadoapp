import 'package:egresadoapp/api/models/user.dart';

enum TipoJornada { partida, completa }

enum Presencialidad { presencial, teletrabajo, mixta, flexible }

extension TipoJornadaExtension on TipoJornada {
  String get value {
    switch (this) {
      case TipoJornada.completa:
        return 'completa';
      case TipoJornada.partida:
        return 'partida';
      default:
        return "none";
    }
  }
}

String getLabelByTipoJornada(String rol) {
  if (rol == TipoJornada.partida.value) {
    return "Partida";
  }
  if (rol == TipoJornada.completa.value) {
    return "Completa";
  }
  return "-";
}

extension PresencialidadExtension on Presencialidad {
  String get value {
    switch (this) {
      case Presencialidad.presencial:
        return 'presencial';
      case Presencialidad.teletrabajo:
        return 'teletrabjo';
      case Presencialidad.mixta:
        return 'mixta';
      case Presencialidad.flexible:
        return 'flexible';
      default:
        return "none";
    }
  }
}

String getLabelByPresencialidad(String estado) {
  if (estado == Presencialidad.presencial.value) {
    return "Presencial";
  }
  if (estado == Presencialidad.teletrabajo.value) {
    return "Teletrabajo";
  }
  if (estado == Presencialidad.mixta.value) {
    return "Mixta";
  }
  if (estado == Presencialidad.flexible.value) {
    return "Flexible";
  }
  return "-";
}

class Oferta {
  String id;
  User autor;
  String titulo;
  String descripcion;
  List<String> skillsRequeridos;
  int fechaPublicacion;
  String localizacion;
  String empleador;
  String salario;
  String tipoJornada;
  String presencialidad;
  String experienciaMinima;
  String contacto;
  Oferta(
      {required this.id,
      required this.autor,
      required this.titulo,
      required this.descripcion,
      required this.skillsRequeridos,
      required this.fechaPublicacion,
      required this.localizacion,
      required this.empleador,
      required this.experienciaMinima,
      required this.contacto,
      required this.presencialidad,
      required this.salario,
      required this.tipoJornada});
  factory Oferta.fromJson(Map<String, dynamic> map) {
    return Oferta(
        id: map["_id"],
        autor: User.fromJson(map["autor"]),
        titulo: map["titulo"],
        descripcion: map["descripcion"],
        skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        fechaPublicacion: map["fechaPublicacion"],
        localizacion: map["localizacion"],
        empleador: map["empleador"],
        experienciaMinima: map["experienciaMinima"],
        contacto: map["contacto"],
        presencialidad: map["presencialidad"],
        salario: map["salario"],
        tipoJornada: map["tipoJornada"]);
  }
  factory Oferta.fromCopy(Oferta oferta) {
    return Oferta(
        id: oferta.id,
        autor: User.fromCopy(oferta.autor),
        titulo: oferta.titulo,
        descripcion: oferta.descripcion,
        skillsRequeridos: oferta.skillsRequeridos.toList(),
        fechaPublicacion: oferta.fechaPublicacion,
        localizacion: oferta.localizacion,
        empleador: oferta.empleador,
        experienciaMinima: oferta.experienciaMinima,
        contacto: oferta.contacto,
        presencialidad: oferta.presencialidad,
        salario: oferta.salario,
        tipoJornada: oferta.tipoJornada);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "_id": id,
      "autor": autor.id,
      "titulo": titulo,
      "descripcion": descripcion,
      "skillsRequeridos": skillsRequeridos.toList(),
      "fechaPublicacion": fechaPublicacion,
      "localizacion": localizacion,
      "empleador": empleador,
      "experienciaMinima": experienciaMinima,
      "contacto": contacto,
      "presencialidad": presencialidad,
      "salario": salario,
      "tipoJornada": tipoJornada
    };
    return map;
  }
}
