import 'package:flutter/material.dart';

/// Pastilla de estado para indicadores diarios.
/// Variante informativa (azul pastel): meta de agua.
/// Variante éxito (verde pastel): consumo adecuado.
/// Reutilizable en Indicadores, Ejercicio y Progreso.
class StatusChip extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const StatusChip({
    super.key,
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
