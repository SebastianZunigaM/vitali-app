import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Barra de navegación inferior del shell principal.
/// 3 secciones: Alimentación (0), Ejercicio (1), Progreso (2).
/// La sección activa muestra barra indicadora superior, ícono y texto en brandMain.
class VitaliBottomNav extends StatelessWidget {
  final int activeIndex;
  final void Function(int)? onTap;

  const VitaliBottomNav({super.key, this.activeIndex = 0, this.onTap});

  static const _labels = ['Alimentación', 'Ejercicio', 'Progreso'];
  static const _icons = [
    Icons.restaurant_outlined,
    Icons.directions_run_rounded,
    Icons.bar_chart_rounded,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 12,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 60,
          child: Row(
            children: List.generate(3, (i) => _NavItem(
              label: _labels[i],
              icon: _icons[i],
              isActive: i == activeIndex,
              onTap: () => onTap?.call(i),
            )),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.brandMain : AppColors.textHint;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          children: [
            // Barra indicadora superior en tab activo
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: isActive ? 28 : 0,
              margin: const EdgeInsets.only(bottom: 6),
              decoration: BoxDecoration(
                color: AppColors.brandMain,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
