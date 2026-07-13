import 'package:flutter/material.dart';

/// Cuadrícula responsiva de dos columnas con altura homogénea por fila.
/// Reutilizable para cualquier selección de categorías en la app.
class CategoryGrid extends StatelessWidget {
  final List<Widget> items;
  final double columnGap;
  final double rowGap;

  const CategoryGrid({
    super.key,
    required this.items,
    this.columnGap = 12,
    this.rowGap = 12,
  });

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];

    for (int i = 0; i < items.length; i += 2) {
      if (rows.isNotEmpty) rows.add(SizedBox(height: rowGap));

      final left = items[i];
      final right = (i + 1 < items.length) ? items[i + 1] : const SizedBox.shrink();

      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: left),
              SizedBox(width: columnGap),
              Expanded(child: right),
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}
