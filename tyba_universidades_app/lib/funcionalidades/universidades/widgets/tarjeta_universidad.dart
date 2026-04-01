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
    elevation: 3,
    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    child: ListTile(
      contentPadding: const EdgeInsets.all(8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          universidad.logoUrl,
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const SizedBox(
              width: 50,
              height: 50,
              child: Center(
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          },
          errorBuilder: (_, __, ___) {
            return Image.network(
              universidad.logoFallback,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 50,
                height: 50,
                color: Colors.grey.shade200,
                child: const Icon(Icons.school, color: Colors.grey),
              ),
            );
          },
        ),
      ),
      title: Text(
        universidad.nombre,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(universidad.pais),
      onTap: onTap,
    ),
  );
}
}