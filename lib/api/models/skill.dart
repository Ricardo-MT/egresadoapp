class Skill {
  String id;
  String nombre;
  Skill({required this.id, required this.nombre});
  factory Skill.fromJson(Map<String, dynamic> map) {
    return Skill(
      id: map['_id'],
      nombre: map['nombre'],
    );
  }
}
