import 'package:egresadoapp/api/models/user.dart';

class EventoBase {
  String titulo;
  String descripcion;
  List<String> skills;
  int fecha;
  String localizacion;
  String? hosts;
  String? contacto;
  EventoBase(
      {required this.titulo,
      required this.descripcion,
      required this.skills,
      required this.fecha,
      required this.localizacion,
      this.hosts,
      this.contacto});

  factory EventoBase.fromJson(Map<String, dynamic> map) {
    return EventoBase(
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skills: ((map["skills"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      fecha: map["fecha"],
      localizacion: map["localizacion"],
      hosts: map["hosts"],
      contacto: map["contacto"],
    );
  }
  factory EventoBase.fromCopy(EventoBase evento) {
    return EventoBase(
      titulo: evento.titulo,
      descripcion: evento.descripcion,
      skills: evento.skills.toList(),
      fecha: evento.fecha,
      localizacion: evento.localizacion,
      hosts: evento.hosts,
      contacto: evento.contacto,
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "titulo": titulo,
      "descripcion": descripcion,
      "skills": skills.toList(),
      "fecha": fecha,
      "localizacion": localizacion,
      "contacto": contacto,
      "hosts": hosts,
    };
    return map;
  }
}

class Evento extends EventoBase {
  String id;
  User autor;
  Evento(
      {required this.id,
      required this.autor,
      required String titulo,
      required String descripcion,
      required List<String> skills,
      required int fecha,
      required String localizacion,
      String? hosts,
      String? contacto})
      : super(
            descripcion: descripcion,
            titulo: titulo,
            skills: skills,
            fecha: fecha,
            localizacion: localizacion,
            hosts: hosts,
            contacto: contacto);
  factory Evento.fromJson(Map<String, dynamic> map) {
    return Evento(
      id: map["_id"],
      autor: User.fromJson(map["autor"]),
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skills: ((map["skills"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      fecha: map["fecha"],
      localizacion: map["localizacion"],
      hosts: map["hosts"],
      contacto: map["contacto"],
    );
  }
  factory Evento.fromCopy(Evento evento) {
    return Evento(
      id: evento.id,
      autor: User.fromCopy(evento.autor),
      titulo: evento.titulo,
      descripcion: evento.descripcion,
      skills: evento.skills.toList(),
      fecha: evento.fecha,
      localizacion: evento.localizacion,
      hosts: evento.hosts,
      contacto: evento.contacto,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "_id": id,
      "autor": autor.id,
      ...super.toJson()
    };
    return map;
  }
}

class EventoCreating extends EventoBase {
  EventoCreating(
      {required String titulo,
      required String descripcion,
      required List<String> skills,
      required int fecha,
      required String localizacion,
      String? hosts,
      String? contacto})
      : super(
            descripcion: descripcion,
            titulo: titulo,
            skills: skills,
            fecha: fecha,
            localizacion: localizacion,
            hosts: hosts,
            contacto: contacto);
  factory EventoCreating.fromJson(Map<String, dynamic> map) {
    return EventoCreating(
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skills: ((map["skills"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      fecha: map["fecha"],
      localizacion: map["localizacion"],
      hosts: map["hosts"],
      contacto: map["contacto"],
    );
  }
  factory EventoCreating.fromCopy(EventoCreating evento) {
    return EventoCreating(
      titulo: evento.titulo,
      descripcion: evento.descripcion,
      skills: evento.skills.toList(),
      fecha: evento.fecha,
      localizacion: evento.localizacion,
      hosts: evento.hosts,
      contacto: evento.contacto,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {...super.toJson()};
    return map;
  }
}

class EventoEditing extends EventoBase {
  String id;
  EventoEditing(
      {required this.id,
      required String titulo,
      required String descripcion,
      required List<String> skills,
      required int fecha,
      required String localizacion,
      String? hosts,
      String? contacto})
      : super(
            descripcion: descripcion,
            titulo: titulo,
            skills: skills,
            fecha: fecha,
            localizacion: localizacion,
            hosts: hosts,
            contacto: contacto);
  factory EventoEditing.fromJson(Map<String, dynamic> map) {
    return EventoEditing(
      id: map["_id"],
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skills: ((map["skills"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      fecha: map["fecha"],
      localizacion: map["localizacion"],
      hosts: map["hosts"],
      contacto: map["contacto"],
    );
  }
  factory EventoEditing.fromCopy(EventoEditing evento) {
    return EventoEditing(
      id: evento.id,
      titulo: evento.titulo,
      descripcion: evento.descripcion,
      skills: evento.skills.toList(),
      fecha: evento.fecha,
      localizacion: evento.localizacion,
      hosts: evento.hosts,
      contacto: evento.contacto,
    );
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {...super.toJson(), "_id": id};
    return map;
  }
}
