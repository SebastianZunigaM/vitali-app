import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/shared/widgets/auth_card.dart';
import 'package:vitali/shared/widgets/brand_header.dart';
import 'package:vitali/shared/widgets/gradient_background.dart';

/// Layout base de todas las pantallas de autenticación.
/// Combina: GradientBackground + BrandHeader + AuthCard + texto motivacional.
class AuthLayout extends StatelessWidget {
  final Widget cardContent;

  const AuthLayout({super.key, required this.cardContent});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 48),

                const BrandHeader(),

                const SizedBox(height: 32),

                AuthCard(child: cardContent),

                const SizedBox(height: 28),

                const Text(
                  'Mejora tu calidad de vida, un hábito a la vez 🌱',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSlogan,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
