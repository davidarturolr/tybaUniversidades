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
  bool cargandoMas = false;

  int pagina = 0;
  final int limite = 20;

  final ScrollController controller = ScrollController();

  @override
  void initState() {
    super.initState();
    cargarDatos();

    controller.addListener(() {
      if (controller.position.pixels >=
              controller.position.maxScrollExtent - 200 &&
          !cargandoMas) {
        cargarMas();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> cargarDatos() async {
    final data = await api.obtenerUniversidades();

    setState(() {
      todas = data;
      visibles = data.take(limite).toList();
      cargando = false;
    });
  }

  Future<void> cargarMas() async {
    if ((pagina + 1) * limite >= todas.length) return;

    setState(() {
      cargandoMas = true;
    });

    await Future.delayed(const Duration(milliseconds: 500));

    setState(() {
      pagina++;
      visibles = todas.take((pagina + 1) * limite).toList();
      cargandoMas = false;
    });
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
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo_tyba.png',
              height: 30,
            ),
            const SizedBox(width: 10),
            const Text('Universidades'),
          ],
        ),
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
      itemCount: visibles.length + (cargandoMas ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= visibles.length) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

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
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.8,
      ),
      itemCount: visibles.length + (cargandoMas ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= visibles.length) {
          return const Center(child: CircularProgressIndicator());
        }

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