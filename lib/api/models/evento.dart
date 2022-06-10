import 'package:egresadoapp/api/models/user.dart';

class Evento {
  String id;
  User autor;
  String titulo;
  String descripcion;
  List<String> skills;
  int fecha;
  String localizacion;
  String? hosts;
  String? contacto;
  Evento(
      {required this.id,
      required this.autor,
      required this.titulo,
      required this.descripcion,
      required this.skills,
      required this.fecha,
      required this.localizacion,
      this.hosts,
      this.contacto});
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
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "_id": id,
      "autor": autor.id,
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
