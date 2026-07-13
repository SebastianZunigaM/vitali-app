import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Fila de 7 días de la semana con estados cumplido/pendiente/hoy.
/// [todayIndex] 0=Lunes … 6=Domingo. Por defecto usa DateTime.now().toLocal().
/// [currentDate] opcional para testing — sobrescribe DateTime.now().
class WeekDaysTracker extends StatelessWidget {
  final List<String> dayLabels;
  final List<bool> dayCompleted;
  final int? todayIndex;
  final DateTime? currentDate;

  const WeekDaysTracker({
    super.key,
    required this.dayLabels,
    required this.dayCompleted,
    this.todayIndex,
    this.currentDate,
  });

  @override
  Widget build(BuildContext context) {
    // weekday: 1=Monday … 7=Sunday → index 0–6
    final today = todayIndex ??
        ((currentDate ?? DateTime.now().toLocal()).weekday - 1);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(dayLabels.length, (i) {
        return _DayCircle(
          label: dayLabels[i],
          isCompleted: dayCompleted[i],
          isToday: i == today,
        );
      }),
    );
  }
}

class _DayCircle extends StatelessWidget {
  final String label;
  final bool isCompleted;
  final bool isToday;

  const _DayCircle({
    required this.label,
    required this.isCompleted,
    required this.isToday,
  });

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
            border: isToday
                ? Border.all(color: AppColors.brandMain, width: 2)
                : null,
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
          style: TextStyle(
            color: isToday ? AppColors.brandMain : AppColors.textSecondary,
            fontSize: 10,
            fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
