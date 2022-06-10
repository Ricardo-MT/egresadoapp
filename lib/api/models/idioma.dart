class Idioma {
  String id;
  String nombre;
  Idioma({required this.id, required this.nombre});
  factory Idioma.fromJson(Map<String, dynamic> map) {
    return Idioma(
      id: map['_id'],
      nombre: map['nombre'],
    );
  }
}
