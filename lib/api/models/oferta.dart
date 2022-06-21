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
        return 'teletrabajo';
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

const listaPresencialidad = ["presencial", "teletrabajo", "mixta", "flexible"];

const listaJornadas = ["partida", "completa"];

class OfertaBase {
  String titulo;
  String descripcion;
  List<String> skillsRequeridos;
  String localizacion;
  String empleador;
  String salario;
  String tipoJornada;
  String presencialidad;
  String experienciaMinima;
  OfertaBase(
      {required this.descripcion,
      required this.empleador,
      required this.experienciaMinima,
      required this.localizacion,
      required this.presencialidad,
      required this.salario,
      required this.skillsRequeridos,
      required this.tipoJornada,
      required this.titulo});

  factory OfertaBase.fromJson(Map<String, dynamic> map) {
    return OfertaBase(
        titulo: map["titulo"],
        descripcion: map["descripcion"],
        skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        localizacion: map["localizacion"],
        empleador: map["empleador"],
        experienciaMinima: map["experienciaMinima"],
        presencialidad: map["presencialidad"],
        salario: map["salario"],
        tipoJornada: map["tipoJornada"]);
  }
  factory OfertaBase.fromCopy(OfertaBase oferta) {
    return OfertaBase(
        titulo: oferta.titulo,
        descripcion: oferta.descripcion,
        skillsRequeridos: oferta.skillsRequeridos.toList(),
        localizacion: oferta.localizacion,
        empleador: oferta.empleador,
        experienciaMinima: oferta.experienciaMinima,
        presencialidad: oferta.presencialidad,
        salario: oferta.salario,
        tipoJornada: oferta.tipoJornada);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "titulo": titulo,
      "descripcion": descripcion,
      "skillsRequeridos": skillsRequeridos.toList(),
      "localizacion": localizacion,
      "empleador": empleador,
      "experienciaMinima": experienciaMinima,
      "presencialidad": presencialidad,
      "salario": salario,
      "tipoJornada": tipoJornada
    };
    return map;
  }
}

class Oferta extends OfertaBase {
  String id;
  User autor;
  int fechaPublicacion;
  Oferta(
      {required this.id,
      required this.autor,
      required this.fechaPublicacion,
      required String titulo,
      required String descripcion,
      required List<String> skillsRequeridos,
      required String localizacion,
      required String empleador,
      required String experienciaMinima,
      required String presencialidad,
      required String salario,
      required String tipoJornada})
      : super(
            titulo: titulo,
            descripcion: descripcion,
            skillsRequeridos: skillsRequeridos,
            salario: salario,
            empleador: empleador,
            localizacion: localizacion,
            experienciaMinima: experienciaMinima,
            presencialidad: presencialidad,
            tipoJornada: tipoJornada);
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
        presencialidad: oferta.presencialidad,
        salario: oferta.salario,
        tipoJornada: oferta.tipoJornada);
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      ...super.toJson(),
      "_id": id,
      "autor": autor.id,
      "fechaPublicacion": fechaPublicacion,
    };
    return map;
  }
}

class OfertaCreating extends OfertaBase {
  OfertaCreating({
    required String titulo,
    required String descripcion,
    required List<String> skillsRequeridos,
    required String localizacion,
    required String empleador,
    required String salario,
    required String tipoJornada,
    required String presencialidad,
    required String experienciaMinima,
  }) : super(
            descripcion: descripcion,
            empleador: empleador,
            experienciaMinima: experienciaMinima,
            localizacion: localizacion,
            presencialidad: presencialidad,
            salario: salario,
            skillsRequeridos: skillsRequeridos,
            tipoJornada: tipoJornada,
            titulo: titulo);
  factory OfertaCreating.fromJson(Map<String, dynamic> map) {
    return OfertaCreating(
        titulo: map["titulo"],
        descripcion: map["descripcion"],
        skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        localizacion: map["localizacion"],
        empleador: map["empleador"],
        experienciaMinima: map["experienciaMinima"],
        presencialidad: map["presencialidad"],
        salario: map["salario"],
        tipoJornada: map["tipoJornada"]);
  }
  factory OfertaCreating.fromCopy(OfertaCreating oferta) {
    return OfertaCreating(
        titulo: oferta.titulo,
        descripcion: oferta.descripcion,
        skillsRequeridos: oferta.skillsRequeridos.toList(),
        localizacion: oferta.localizacion,
        empleador: oferta.empleador,
        experienciaMinima: oferta.experienciaMinima,
        presencialidad: oferta.presencialidad,
        salario: oferta.salario,
        tipoJornada: oferta.tipoJornada);
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {...super.toJson()};
    return map;
  }
}

class OfertaEditing extends OfertaBase {
  String id;
  OfertaEditing(
      {required this.id,
      required String descripcion,
      required String empleador,
      required String experienciaMinima,
      required String localizacion,
      required String presencialidad,
      required String salario,
      required List<String> skillsRequeridos,
      required String tipoJornada,
      required String titulo})
      : super(
            descripcion: descripcion,
            empleador: empleador,
            experienciaMinima: experienciaMinima,
            localizacion: localizacion,
            presencialidad: presencialidad,
            salario: salario,
            skillsRequeridos: skillsRequeridos,
            tipoJornada: tipoJornada,
            titulo: titulo);
  factory OfertaEditing.fromJson(Map<String, dynamic> map) {
    return OfertaEditing(
        id: map["_id"],
        titulo: map["titulo"],
        descripcion: map["descripcion"],
        skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        localizacion: map["localizacion"],
        empleador: map["empleador"],
        experienciaMinima: map["experienciaMinima"],
        presencialidad: map["presencialidad"],
        salario: map["salario"],
        tipoJornada: map["tipoJornada"]);
  }
  factory OfertaEditing.fromCopy(OfertaEditing oferta) {
    return OfertaEditing(
        id: oferta.id,
        titulo: oferta.titulo,
        descripcion: oferta.descripcion,
        skillsRequeridos: oferta.skillsRequeridos.toList(),
        localizacion: oferta.localizacion,
        empleador: oferta.empleador,
        experienciaMinima: oferta.experienciaMinima,
        presencialidad: oferta.presencialidad,
        salario: oferta.salario,
        tipoJornada: oferta.tipoJornada);
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      ...super.toJson(),
      "_id": id,
    };
    return map;
  }
}
