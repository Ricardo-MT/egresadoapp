enum Direction { asc, desc }

extension DirectionExtension on Direction {
  int get value {
    switch (this) {
      case Direction.asc:
        return 1;
      case Direction.desc:
        return -1;
      default:
        return 1;
    }
  }
}

class SortFilter {
  String sortBy;
  Direction direction;
  SortFilter({this.sortBy = "", this.direction = Direction.asc});
}

class FiltroUsuarios {
  late final List<String> baseIdiomas;
  late List<String> idiomas = [];
  late final List<String> baseSkills;
  late List<String> skills = [];
  late final List<String> baseEstado;
  late List<String> estados = [];
  late final List<String> baseRoles;
  late List<String> roles = [];

  FiltroUsuarios({
    required this.baseIdiomas,
    required this.idiomas,
    required this.baseEstado,
    required this.estados,
    required this.baseRoles,
    required this.roles,
    required this.baseSkills,
    required this.skills,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (idiomas.isNotEmpty) {
      map["idiomas"] = idiomas;
    }
    if (skills.isNotEmpty) {
      map["skills"] = skills;
    }
    if (estados.isNotEmpty) {
      map["estado"] = estados;
    }
    if (roles.isNotEmpty) {
      map["rol"] = roles;
    }
    return map;
  }

  factory FiltroUsuarios.fromCopy(FiltroUsuarios toCopy) {
    return FiltroUsuarios(
        baseEstado: toCopy.baseEstado,
        estados: toCopy.estados,
        baseIdiomas: toCopy.baseIdiomas,
        idiomas: toCopy.idiomas,
        baseRoles: toCopy.baseRoles,
        roles: toCopy.roles,
        baseSkills: toCopy.baseSkills,
        skills: toCopy.skills);
  }
}

class FiltroOfertas {
  int? fechaPublicacionInicio;
  int? fechaPublicacionFin;
  late final List<String> baseTipoJornada;
  late List<String> tipoJornada = [];
  late final List<String> baseSkillsRequeridos;
  late List<String> skillsRequeridos = [];
  late final List<String> basePresencialidad;
  late List<String> presencialidad = [];

  FiltroOfertas(
      {required this.baseTipoJornada,
      required this.tipoJornada,
      required this.basePresencialidad,
      required this.presencialidad,
      required this.baseSkillsRequeridos,
      required this.skillsRequeridos,
      this.fechaPublicacionFin,
      this.fechaPublicacionInicio});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (tipoJornada.isNotEmpty) {
      map["tipoJornada"] = tipoJornada;
    }
    if (skillsRequeridos.isNotEmpty) {
      map["skillsRequeridos"] = skillsRequeridos;
    }
    if (presencialidad.isNotEmpty) {
      map["presencialidad"] = presencialidad;
    }
    if (fechaPublicacionInicio != null) {
      map["fechaPublicacionInicio"] = fechaPublicacionInicio.toString();
    }
    if (fechaPublicacionFin != null) {
      map["fechaPublicacionFin"] = fechaPublicacionFin.toString();
    }
    return map;
  }

  factory FiltroOfertas.fromCopy(FiltroOfertas toCopy) {
    return FiltroOfertas(
        basePresencialidad: toCopy.basePresencialidad,
        presencialidad: toCopy.presencialidad,
        baseTipoJornada: toCopy.tipoJornada,
        tipoJornada: toCopy.tipoJornada,
        baseSkillsRequeridos: toCopy.baseSkillsRequeridos,
        skillsRequeridos: toCopy.skillsRequeridos,
        fechaPublicacionFin: toCopy.fechaPublicacionFin,
        fechaPublicacionInicio: toCopy.fechaPublicacionInicio);
  }
}

class FiltroEventos {
  int? fechaInicio;
  int? fechaFin;
  late final List<String> baseSkills;
  late List<String> skills = [];

  FiltroEventos(
      {required this.baseSkills,
      required this.skills,
      this.fechaFin,
      this.fechaInicio});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (skills.isNotEmpty) {
      map["skills"] = skills;
    }
    if (fechaInicio != null) {
      map["fechaInicio"] = fechaInicio.toString();
    }
    if (fechaFin != null) {
      map["fechaFin"] = fechaFin.toString();
    }
    return map;
  }

  factory FiltroEventos.fromCopy(FiltroEventos toCopy) {
    return FiltroEventos(
        baseSkills: toCopy.baseSkills,
        skills: toCopy.skills,
        fechaFin: toCopy.fechaFin,
        fechaInicio: toCopy.fechaInicio);
  }
}

class FiltroColaboracion {
  int? fechaPublicacionInicio;
  int? fechaPublicacionFin;
  late final List<String> baseSkillsRequeridos;
  late List<String> skillsRequeridos = [];

  FiltroColaboracion(
      {required this.baseSkillsRequeridos,
      required this.skillsRequeridos,
      this.fechaPublicacionFin,
      this.fechaPublicacionInicio});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    if (skillsRequeridos.isNotEmpty) {
      map["skillsRequeridos"] = skillsRequeridos;
    }
    if (fechaPublicacionInicio != null) {
      map["fechaPublicacionInicio"] = fechaPublicacionInicio.toString();
    }
    if (fechaPublicacionFin != null) {
      map["fechaPublicacionFin"] = fechaPublicacionFin.toString();
    }
    return map;
  }

  factory FiltroColaboracion.fromCopy(FiltroColaboracion toCopy) {
    return FiltroColaboracion(
        baseSkillsRequeridos: toCopy.baseSkillsRequeridos,
        skillsRequeridos: toCopy.skillsRequeridos,
        fechaPublicacionFin: toCopy.fechaPublicacionFin,
        fechaPublicacionInicio: toCopy.fechaPublicacionInicio);
  }
}
