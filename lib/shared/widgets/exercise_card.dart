import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/shared/widgets/complete_action_button.dart';
import 'package:vitali/shared/widgets/intensity_badge.dart';

/// Tarjeta individual de ejercicio con soporte de expansión acordeón.
/// Estado colapsado (P12): emoji + título + duración + IntensityBadge
///   + botón circular + chevron abajo.
/// Estado expandido (P13): misma cabecera + descripción + CompleteActionButton.
/// Todos los parámetros de expansión son opcionales para mantener retrocompatibilidad.
class ExerciseCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String duration;
  final ExerciseIntensity intensity;
  final bool isExpanded;
  final String? description;
  final VoidCallback? onCompletePressed;
  final VoidCallback? onToggleExpanded;

  const ExerciseCard({
    super.key,
    required this.emoji,
    required this.title,
    required this.duration,
    required this.intensity,
    this.isExpanded = false,
    this.description,
    this.onCompletePressed,
    this.onToggleExpanded,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggleExpanded,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0F000000),
              blurRadius: 14,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Fila principal (siempre visible) ──────────────────────
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: 12),

                // Título + duración + badge de intensidad
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 13,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            duration,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 8),
                          IntensityBadge(intensity: intensity),
                        ],
                      ),
                    ],
                  ),
                ),

                // Botón circular de acción
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: AppColors.brandMain,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.textOnGreen,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 6),

                // Chevron — apunta arriba cuando está expandida
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textHint,
                  size: 22,
                ),
              ],
            ),

            // ── Contenido expandible animado ──────────────────────────
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: (isExpanded && description != null)
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        const Divider(
                          height: 1,
                          thickness: 0.8,
                          color: AppColors.imcMuted,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          description!,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        CompleteActionButton(onPressed: onCompletePressed),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
