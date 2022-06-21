import 'package:egresadoapp/api/models/user.dart';

class ColaboracionBase {
  String titulo;
  String descripcion;
  List<String> skillsRequeridos;
  ColaboracionBase({
    required this.titulo,
    required this.descripcion,
    required this.skillsRequeridos,
  });
  factory ColaboracionBase.fromJson(Map<String, dynamic> map) {
    return ColaboracionBase(
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }
  factory ColaboracionBase.fromCopy(ColaboracionBase colaboracion) {
    return ColaboracionBase(
      titulo: colaboracion.titulo,
      descripcion: colaboracion.descripcion,
      skillsRequeridos: colaboracion.skillsRequeridos.toList(),
    );
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "titulo": titulo,
      "descripcion": descripcion,
      "skillsRequeridos": skillsRequeridos.toList(),
    };
    return map;
  }
}

class Colaboracion extends ColaboracionBase {
  String id;
  User autor;
  int fechaPublicacion;
  Colaboracion({
    required this.id,
    required this.autor,
    required String titulo,
    required String descripcion,
    required List<String> skillsRequeridos,
    required this.fechaPublicacion,
  }) : super(
            titulo: titulo,
            descripcion: descripcion,
            skillsRequeridos: skillsRequeridos);
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
    );
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

class ColaboracionCreating extends ColaboracionBase {
  ColaboracionCreating({
    required String titulo,
    required String descripcion,
    required List<String> skillsRequeridos,
  }) : super(
            titulo: titulo,
            descripcion: descripcion,
            skillsRequeridos: skillsRequeridos);
  factory ColaboracionCreating.fromJson(Map<String, dynamic> map) {
    return ColaboracionCreating(
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }
  factory ColaboracionCreating.fromCopy(ColaboracionCreating colaboracion) {
    return ColaboracionCreating(
      titulo: colaboracion.titulo,
      descripcion: colaboracion.descripcion,
      skillsRequeridos: colaboracion.skillsRequeridos.toList(),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      ...super.toJson(),
    };
    return map;
  }
}

class ColaboracionEditing extends ColaboracionBase {
  String id;
  ColaboracionEditing({
    required this.id,
    required String titulo,
    required String descripcion,
    required List<String> skillsRequeridos,
  }) : super(
            titulo: titulo,
            descripcion: descripcion,
            skillsRequeridos: skillsRequeridos);
  factory ColaboracionEditing.fromJson(Map<String, dynamic> map) {
    return ColaboracionEditing(
      id: map["_id"],
      titulo: map["titulo"],
      descripcion: map["descripcion"],
      skillsRequeridos: ((map["skillsRequeridos"] ?? []) as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
    );
  }
  factory ColaboracionEditing.fromCopy(ColaboracionEditing colaboracion) {
    return ColaboracionEditing(
      id: colaboracion.id,
      titulo: colaboracion.titulo,
      descripcion: colaboracion.descripcion,
      skillsRequeridos: colaboracion.skillsRequeridos.toList(),
    );
  }
  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {...super.toJson(), "_id": id};
    return map;
  }
}
