import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Pastilla de acción positiva: icono check + texto blanco semibold.
/// Ancho ajustado al contenido (MainAxisSize.min).
/// Reutilizable en ExerciseCard (P13) y hábitos de Progreso (P14).
class CompleteActionButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isCompleted;

  const CompleteActionButton({
    super.key,
    this.onPressed,
    this.isCompleted = false,
  });

  @override
  Widget build(BuildContext context) {
    final bg = isCompleted ? AppColors.successBg : AppColors.brandMain;
    final fg = isCompleted ? AppColors.successText : AppColors.textOnGreen;
    final label = isCompleted ? 'Completado' : 'Marcar como completado';

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_rounded, color: fg, size: 16),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: fg,
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
