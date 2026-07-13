import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Selector de franjas de comida: Desayuno / Almuerzo / Cena.
class MealTabsSelector extends StatelessWidget {
  final int activeIndex;
  final void Function(int)? onTabChanged;

  const MealTabsSelector({
    super.key,
    this.activeIndex = 0,
    this.onTabChanged,
  });

  static const _tabs = [
    ('🌅', 'Desayuno'),
    ('☀️', 'Almuerzo'),
    ('🌙', 'Cena'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
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
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final isActive = i == activeIndex;
          final tab = _tabs[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged?.call(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
                decoration: BoxDecoration(
                  color: isActive ? AppColors.brandMid : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(tab.$1, style: const TextStyle(fontSize: 13)),
                    const SizedBox(width: 4),
                    Flexible(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          tab.$2,
                          maxLines: 1,
                          style: TextStyle(
                            color: isActive
                                ? AppColors.textOnGreen
                                : AppColors.textPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
