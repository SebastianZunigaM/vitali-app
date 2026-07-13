import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

enum ImcClassification {
  underweight,
  healthy,
  overweight,
  obese,
}

extension ImcClassificationExt on ImcClassification {
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

class ImcResultCard extends StatelessWidget {
  final double imcValue;
  final ImcClassification classification;

  const ImcResultCard({
    super.key,
    required this.imcValue,
    required this.classification,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          imcValue.toStringAsFixed(1),
          style: const TextStyle(
            color: AppColors.brandMid,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: classification.badgeBg,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                classification.icon,
                color: classification.badgeText,
                size: 15,
              ),
              const SizedBox(width: 6),
              Text(
                classification.label,
                style: TextStyle(
                  color: classification.badgeText,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
