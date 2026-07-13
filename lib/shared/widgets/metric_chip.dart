import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Chip translúcido para mostrar métricas dentro del encabezado verde.
/// Fondo: rgba(255,255,255,0.14). Valor en blanco bold, etiqueta en verde claro.
/// Usado en Pantalla 12 (Ejercicio) y futuro Pantalla 14 (Progreso).
class MetricChip extends StatelessWidget {
  final String value;
  final String label;
  final IconData? icon;

  const MetricChip({
    super.key,
    required this.value,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x24FFFFFF),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, color: AppColors.textOnGreen, size: 13),
            const SizedBox(width: 5),
          ],
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textOnGreen,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSlogan,
                  fontSize: 9,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
