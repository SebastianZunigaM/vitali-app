import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Token semántico de intensidad de ejercicio: Suave / Moderada / Alta.
/// Cada variante tiene su par bg+texto definido en AppColors.
/// Reutilizable en ExerciseCard (P12) y futuras pantallas de detalle (P13).
enum ExerciseIntensity { soft, moderate, high }

class IntensityBadge extends StatelessWidget {
  final ExerciseIntensity intensity;

  const IntensityBadge({super.key, required this.intensity});

  static const _labels = {
    ExerciseIntensity.soft: 'Suave',
    ExerciseIntensity.moderate: 'Moderada',
    ExerciseIntensity.high: 'Alta',
  };

  static const _bgColors = {
    ExerciseIntensity.soft: AppColors.intensitySoftBg,
    ExerciseIntensity.moderate: AppColors.intensityModerateBg,
    ExerciseIntensity.high: AppColors.intensityHighBg,
  };

  static const _textColors = {
    ExerciseIntensity.soft: AppColors.intensitySoftText,
    ExerciseIntensity.moderate: AppColors.intensityModerateText,
    ExerciseIntensity.high: AppColors.intensityHighText,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _bgColors[intensity],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        _labels[intensity]!,
        style: TextStyle(
          color: _textColors[intensity],
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
