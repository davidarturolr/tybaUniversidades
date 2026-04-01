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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(uni.pais),
            const SizedBox(height: 10),

            if (uni.imagenLocal != null)
              Image.file(File(uni.imagenLocal!)),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.camera),
                  onPressed: () =>
                      seleccionarImagen(ImageSource.camera),
                ),
                IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: () =>
                      seleccionarImagen(ImageSource.gallery),
                ),
              ],
            ),

            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Número de estudiantes',
                errorText: error,
              ),
              onChanged: validarInput,
            ),
          ],
        ),
      ),
    );
  }
}