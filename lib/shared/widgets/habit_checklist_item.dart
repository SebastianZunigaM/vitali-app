import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Elemento de checklist de hábitos: checkbox circular + emoji + etiqueta.
/// Sin lógica de estado real; el estado marcado/no marcado es puramente visual.
/// Reutilizable en Mi Progreso (P14) y futuros módulos de hábitos.
class HabitChecklistItem extends StatelessWidget {
  final String emoji;
  final String label;
  final bool isChecked;
  final VoidCallback? onTap;

  const HabitChecklistItem({
    super.key,
    required this.emoji,
    required this.label,
    this.isChecked = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Row(
        children: [
          // Checkbox circular
          Container(
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isChecked ? AppColors.brandMain : Colors.transparent,
              border: Border.all(
                color: isChecked ? AppColors.brandMain : AppColors.imcMuted,
                width: 1.5,
              ),
            ),
            child: isChecked
                ? const Icon(
                    Icons.check_rounded,
                    color: AppColors.textOnGreen,
                    size: 13,
                  )
                : null,
          ),
          const SizedBox(width: 10),
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              label,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
