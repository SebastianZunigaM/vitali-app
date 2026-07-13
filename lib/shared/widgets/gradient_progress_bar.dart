import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Barra de progreso horizontal con degradado verde → azul.
/// El ancho de la barra rellena es proporcional a [progress] (0.0 a 1.0).
/// Reutilizable en Mi Progreso (P14) y futuros dashboards.
class GradientProgressBar extends StatelessWidget {
  final double progress;
  final List<Color> colors;
  final double height;
  final Color trackColor;

  const GradientProgressBar({
    super.key,
    required this.progress,
    this.colors = const [AppColors.brandMain, AppColors.brandBlue],
    this.height = 8,
    this.trackColor = AppColors.successBg,
  });

  @override
  Widget build(BuildContext context) {
    final clamped = progress.clamp(0.0, 1.0);
    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(
        children: [
          // Pista de fondo
          Container(
            height: height,
            width: double.infinity,
            color: trackColor,
          ),
          // Barra de avance con degradado
          FractionallySizedBox(
            widthFactor: clamped,
            child: Container(
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: colors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
