import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/shared/widgets/complete_action_button.dart';
import 'package:vitali/shared/widgets/intensity_badge.dart';

/// Tarjeta individual de ejercicio con soporte de expansión acordeón.
/// El botón circular tiene su propio GestureDetector — funciona en todas las
/// tarjetas independientemente de si tienen descripción expandible.
class ExerciseCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String duration;
  final ExerciseIntensity intensity;
  final bool isExpanded;
  final bool isCompleted;
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
    this.isCompleted = false,
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
                Text(emoji, style: const TextStyle(fontSize: 26)),
                const SizedBox(width: 10),

                // Título + duración + badge de intensidad
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_rounded,
                            size: 12,
                            color: AppColors.textSecondary,
                          ),
                          const SizedBox(width: 3),
                          Text(
                            duration,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Flexible(child: IntensityBadge(intensity: intensity)),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                // Botón circular — tiene su propio GestureDetector para no
                // depender de la expansión del acordeón.
                GestureDetector(
                  onTap: onCompletePressed,
                  child: Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? AppColors.successBg
                          : AppColors.brandMain,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCompleted
                          ? Icons.check_rounded
                          : Icons.play_arrow_rounded,
                      color: isCompleted
                          ? AppColors.successText
                          : AppColors.textOnGreen,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 4),

                // Chevron — apunta arriba cuando está expandida
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: AppColors.textHint,
                  size: 20,
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
                        CompleteActionButton(
                          onPressed: onCompletePressed,
                          isCompleted: isCompleted,
                        ),
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
