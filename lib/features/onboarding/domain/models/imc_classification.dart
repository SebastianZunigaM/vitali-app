import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

enum ImcClassification { underweight, healthy, overweight, obese }

extension ImcClassificationExt on ImcClassification {
  /// Convierte el string guardado en Supabase de vuelta al enum.
  /// Fallback a [ImcClassification.healthy] si el valor no coincide.
  static ImcClassification fromName(String name) {
    switch (name) {
      case 'underweight':
        return ImcClassification.underweight;
      case 'healthy':
        return ImcClassification.healthy;
      case 'overweight':
        return ImcClassification.overweight;
      case 'obese':
        return ImcClassification.obese;
      default:
        return ImcClassification.healthy;
    }
  }

  String get label {
    switch (this) {
      case ImcClassification.underweight:
        return 'Bajo peso';
      case ImcClassification.healthy:
        return 'Peso saludable';
      case ImcClassification.overweight:
        return 'Sobrepeso';
      case ImcClassification.obese:
        return 'Obesidad';
    }
  }

  Color get badgeBg {
    switch (this) {
      case ImcClassification.underweight:
        return AppColors.waterPastel;
      case ImcClassification.healthy:
        return AppColors.successBg;
      case ImcClassification.overweight:
        return AppColors.saltPastel;
      case ImcClassification.obese:
        return const Color(0xFFFFE5E5);
    }
  }

  Color get badgeText {
    switch (this) {
      case ImcClassification.underweight:
        return AppColors.water;
      case ImcClassification.healthy:
        return AppColors.brandMid;
      case ImcClassification.overweight:
        return AppColors.salt;
      case ImcClassification.obese:
        return const Color(0xFFC62828);
    }
  }

  IconData get icon {
    switch (this) {
      case ImcClassification.underweight:
        return Icons.arrow_downward_rounded;
      case ImcClassification.healthy:
        return Icons.check_circle_rounded;
      case ImcClassification.overweight:
        return Icons.arrow_upward_rounded;
      case ImcClassification.obese:
        return Icons.warning_amber_rounded;
    }
  }
}
