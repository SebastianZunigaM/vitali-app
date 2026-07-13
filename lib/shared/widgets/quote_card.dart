import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Tarjeta de cita motivacional semanal sobre fondo verde sólido.
/// Estructura: etiqueta (FRASE DE LA SEMANA) + cita + autor.
/// Parametrizable para contenido rotativo y pantallas de bienestar.
class QuoteCard extends StatelessWidget {
  final String label;
  final String quote;
  final String author;
  final Color backgroundColor;

  const QuoteCard({
    super.key,
    required this.label,
    required this.quote,
    required this.author,
    this.backgroundColor = AppColors.brandMid,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Etiqueta en mayúsculas con tracking amplio
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSlogan,
              fontSize: 9,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 10),
          // Cita principal
          Text(
            quote,
            style: const TextStyle(
              color: AppColors.textOnGreen,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 6),
          // Autor
          Text(
            author,
            style: TextStyle(
              color: AppColors.textOnGreen.withValues(alpha: 0.75),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
