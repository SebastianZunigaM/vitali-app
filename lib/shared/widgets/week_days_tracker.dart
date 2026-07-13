import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Fila de 7 días de la semana con estados cumplido/pendiente.
/// Días cumplidos: círculo verde sólido con check blanco.
/// Días pendientes: círculo verde pastel vacío.
/// Reutilizable en Mi Progreso (P14) y futuras vistas de racha.
class WeekDaysTracker extends StatelessWidget {
  final List<String> dayLabels;
  final List<bool> dayCompleted;

  const WeekDaysTracker({
    super.key,
    required this.dayLabels,
    required this.dayCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(dayLabels.length, (i) {
        return _DayCircle(
          label: dayLabels[i],
          isCompleted: dayCompleted[i],
        );
      }),
    );
  }
}

class _DayCircle extends StatelessWidget {
  final String label;
  final bool isCompleted;

  const _DayCircle({required this.label, required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isCompleted ? AppColors.brandMain : AppColors.successBg,
            shape: BoxShape.circle,
          ),
          child: isCompleted
              ? const Icon(
                  Icons.check_rounded,
                  color: AppColors.textOnGreen,
                  size: 18,
                )
              : null,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 10,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
