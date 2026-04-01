import 'package:flutter/material.dart';
import '../../../datos/modelos/universidad.dart';
import '../../../datos/servicios/servicio_api.dart';
import '../widgets/tarjeta_universidad.dart';
import 'detalle_universidad.dart';

class ListaUniversidades extends StatefulWidget {
  const ListaUniversidades({super.key});

  @override
  State<ListaUniversidades> createState() => _ListaUniversidadesState();
}

class _ListaUniversidadesState extends State<ListaUniversidades> {
  final ServicioApi api = ServicioApi();

  List<Universidad> todas = [];
  List<Universidad> visibles = [];

  bool esGrid = false;
  bool cargando = true;

  int pagina = 0;
  final int limite = 20;

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    cargarDatos();

    controller.addListener(() {
      if (controller.position.pixels ==
          controller.position.maxScrollExtent) {
        cargarMas();
      }
    });
  }

  Future<void> cargarDatos() async {
    final data = await api.obtenerUniversidades();

    setState(() {
      todas = data;
      visibles = data.take(limite).toList();
      cargando = false;
    });
  }

  void cargarMas() {
    final siguiente = (pagina + 1) * limite;

    if (siguiente < todas.length) {
      setState(() {
        pagina++;
        visibles = todas.take((pagina + 1) * limite).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargando) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades'),
        actions: [
          IconButton(
            icon: Icon(esGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                esGrid = !esGrid;
              });
            },
          )
        ],
      ),
      body: esGrid ? construirGrid() : construirLista(),
    );
  }

  Widget construirLista() {
    return ListView.builder(
      controller: controller,
      itemCount: visibles.length,
      itemBuilder: (context, index) {
        final uni = visibles[index];

        return TarjetaUniversidad(
          universidad: uni,
          onTap: () => irDetalle(uni),
        );
      },
    );
  }

  Widget construirGrid() {
    return GridView.builder(
      controller: controller,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: visibles.length,
      itemBuilder: (context, index) {
        final uni = visibles[index];

        return TarjetaUniversidad(
          universidad: uni,
          onTap: () => irDetalle(uni),
        );
      },
    );
  }

  void irDetalle(Universidad uni) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetalleUniversidad(universidad: uni),
      ),
    );
  }
}