import 'package:flutter/material.dart';
import 'funcionalidades/universidades/vistas/lista_universidades.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tyba Universidades',
      debugShowCheckedModeBanner: false,
      home: const ListaUniversidades(),
    );
  }
}