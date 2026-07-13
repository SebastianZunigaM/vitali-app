import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Cabecera verde con degradado y esquinas INFERIORES redondeadas (~20 dp).
/// Base de todas las vistas internas (Pantallas 04–14).
/// El contenido específico (saludo, título de sección, chips) se pasa como [child].
class GreenHeader extends StatelessWidget {
  final Widget child;

  const GreenHeader({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientHeader,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: child,
    );
  }
}
