class Universidad {
  final String nombre;
  final String pais;
  final List<String> dominios;
  final List<String> paginasWeb;

  String? imagenLocal;
  int? numeroEstudiantes;

  Universidad({
    required this.nombre,
    required this.pais,
    required this.dominios,
    required this.paginasWeb,
  });

  factory Universidad.fromJson(Map<String, dynamic> json) {
    return Universidad(
      nombre: json['name'],
      pais: json['country'],
      dominios: List<String>.from(json['domains']),
      paginasWeb: List<String>.from(json['web_pages']),
    );
  }
}