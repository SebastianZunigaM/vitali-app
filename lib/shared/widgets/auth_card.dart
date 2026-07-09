import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Tarjeta blanca contenedora de formularios de autenticación.
/// Radio ≈24 dp, sombra suave. Usada en Login, Register y Login+Confirmación.
class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 24,
            spreadRadius: 0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
