import 'package:flutter/material.dart';

/// Fila responsiva de dos campos de igual ancho separados por [gap].
/// Usada en Pantalla 04 (Edad / Peso) y futuros formularios.
class TwoColumnFieldRow extends StatelessWidget {
  final Widget left;
  final Widget right;
  final double gap;

  const TwoColumnFieldRow({
    super.key,
    required this.left,
    required this.right,
    this.gap = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: left),
        SizedBox(width: gap),
        Expanded(child: right),
      ],
    );
  }
}
