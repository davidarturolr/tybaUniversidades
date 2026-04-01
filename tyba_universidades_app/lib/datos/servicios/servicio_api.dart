import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modelos/universidad.dart';

class ServicioApi {
  final String url =
      'https://tyba-assets.s3.amazonaws.com/FE-Engineer-test/universities.json';

  Future<List<Universidad>> obtenerUniversidades() async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Universidad.fromJson(e)).toList();
    } else {
      throw Exception('Error al cargar universidades');
    }
  }
}
