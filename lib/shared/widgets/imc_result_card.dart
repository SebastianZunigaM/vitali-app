import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/features/onboarding/domain/models/imc_classification.dart';

export 'package:vitali/features/onboarding/domain/models/imc_classification.dart';

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
