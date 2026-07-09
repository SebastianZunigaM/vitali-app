import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Isotipo + logotipo "VITALI" + eslogan de marca.
/// Usado en las pantallas de autenticación.
class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Isotipo(),
        const SizedBox(height: 16),
        const Text(
          'VITALI',
          style: TextStyle(
            color: AppColors.textOnGreen,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 10,
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Tu bienestar, nuestra misión',
          style: TextStyle(
            color: AppColors.textSlogan,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _Isotipo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const size = 76.0;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: AppColors.gradientButtonPrimary,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Color(0x442BA05F),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 6),
          ),
          BoxShadow(
            color: Color(0x22FFFFFF),
            blurRadius: 30,
            spreadRadius: 8,
          ),
        ],
      ),
      child: const Icon(
        Icons.monitor_heart_outlined,
        color: AppColors.textOnGreen,
        size: 42,
      ),
    );
  }
}
