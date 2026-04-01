import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../datos/modelos/universidad.dart';

class DetalleUniversidad extends StatefulWidget {
  final Universidad universidad;

  const DetalleUniversidad({super.key, required this.universidad});

  @override
  State<DetalleUniversidad> createState() => _DetalleUniversidadState();
}

class _DetalleUniversidadState extends State<DetalleUniversidad> {
  final picker = ImagePicker();
  final TextEditingController controller = TextEditingController();

  String? error;

  Future<void> seleccionarImagen(ImageSource source) async {
    final picked = await picker.pickImage(source: source);

    if (picked != null) {
      setState(() {
        widget.universidad.imagenLocal = picked.path;
      });
    }
  }

  void validarInput(String value) {
    final numero = int.tryParse(value);

    setState(() {
      if (numero == null || numero <= 0) {
        error = 'Ingrese un número válido';
      } else {
        error = null;
        widget.universidad.numeroEstudiantes = numero;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final uni = widget.universidad;

    return Scaffold(
      appBar: AppBar(title: Text(uni.nombre)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              uni.nombre,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.flag, size: 16, color: Colors.grey),
                const SizedBox(width: 6),
                Text(uni.pais, style: const TextStyle(fontSize: 15)),
              ],
            ),
            const SizedBox(height: 12),
            if (uni.dominios.isNotEmpty) ...[
              const Text(
                'Dominios',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              ...uni.dominios.map(
                (d) => Text(d, style: const TextStyle(fontSize: 13)),
              ),
              const SizedBox(height: 12),
            ],
            if (uni.paginasWeb.isNotEmpty) ...[
              const Text(
                'Páginas web',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 4),
              ...uni.paginasWeb.map(
                (url) => Text(
                  url,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
            const Divider(),
            const SizedBox(height: 12),
            const Text(
              'Imagen de la universidad',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            if (uni.imagenLocal != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(
                  File(uni.imagenLocal!),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera_alt),
                  tooltip: 'Tomar foto',
                  onPressed: () => seleccionarImagen(ImageSource.camera),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  tooltip: 'Elegir de galería',
                  onPressed: () => seleccionarImagen(ImageSource.gallery),
                ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de estudiantes',
                errorText: error,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.people),
              ),
              onChanged: validarInput,
            ),
          ],
        ),
      ),
    );
  }
}