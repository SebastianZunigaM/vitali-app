import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Pastilla de acción positiva: icono check + texto blanco semibold.
/// Ancho ajustado al contenido (MainAxisSize.min).
/// Reutilizable en ExerciseCard (P13) y hábitos de Progreso (P14).
class CompleteActionButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const CompleteActionButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.brandMain,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.check_rounded, color: AppColors.textOnGreen, size: 16),
            SizedBox(width: 8),
            Text(
              'Marcar como completado',
              style: TextStyle(
                color: AppColors.textOnGreen,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
