import 'package:egresadoapp/api/models/user.dart';

class Colaboracion {
  String id;
  User autor;
  String titulo;
  String descripcion;
  List<String> skillsRequeridos;
  int fechaPublicacion;
  String contacto;
  Colaboracion({
    required this.id,
    required this.autor,
    required this.titulo,
    required this.descripcion,
    required this.skillsRequeridos,
    required this.fechaPublicacion,
    required this.contacto,
  });
  factory Colaboracion.fromJson(Map<String, dynamic> map) {
    return Colaboracion(
      id: map["_id"],
      autor: User.fromJson(map["autor"]),
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      fechaPublicacion: map["fechaPublicacion"],
      contacto: map["contacto"],
    );
  }
  factory Colaboracion.fromCopy(Colaboracion colaboracion) {
    return Colaboracion(
      id: colaboracion.id,
      autor: User.fromCopy(colaboracion.autor),
      titulo: colaboracion.titulo,
      descripcion: colaboracion.descripcion,
      skillsRequeridos: colaboracion.skillsRequeridos.toList(),
      fechaPublicacion: colaboracion.fechaPublicacion,
      contacto: colaboracion.contacto,
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "_id": id,
      "autor": autor.id,
      "titulo": titulo,
      "descripcion": descripcion,
      "skillsRequeridos": skillsRequeridos.toList(),
      "fechaPublicacion": fechaPublicacion,
      "contacto": contacto,
    };
    return map;
  }
}
