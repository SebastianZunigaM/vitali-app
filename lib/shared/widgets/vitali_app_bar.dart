import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Barra de aplicación superior del shell principal.
/// Muestra la marca compacta VITALI + isotipo y el botón Salir.
/// Reutilizable en Alimentación, Ejercicio y Progreso.
class VitaliAppBar extends StatelessWidget {
  final VoidCallback? onSalir;

  const VitaliAppBar({super.key, this.onSalir});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientHeader,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Isotipo compacto
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.brandForest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.monitor_heart_outlined,
                    color: AppColors.textOnGreen,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'VITALI',
                  style: TextStyle(
                    color: AppColors.textOnGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                const Spacer(),
                // Botón Salir — pastilla verde oscuro con borde sutil
                GestureDetector(
                  onTap: onSalir,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.brandForest,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x33FFFFFF),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.exit_to_app_rounded,
                          color: AppColors.textOnGreen,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Salir',
                          style: TextStyle(
                            color: AppColors.textOnGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
