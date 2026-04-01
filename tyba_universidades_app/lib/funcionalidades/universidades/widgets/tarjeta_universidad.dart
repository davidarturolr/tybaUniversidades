import 'package:flutter/material.dart';
import '../../../datos/modelos/universidad.dart';

class TarjetaUniversidad extends StatelessWidget {
  final Universidad universidad;
  final VoidCallback onTap;

  const TarjetaUniversidad({
    super.key,
    required this.universidad,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(universidad.nombre),
        subtitle: Text(universidad.pais),
        onTap: onTap,
      ),
    );
  }
}