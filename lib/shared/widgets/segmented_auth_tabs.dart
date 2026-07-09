import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

class SegmentedAuthTabs extends StatelessWidget {
  final int activeIndex;
  final VoidCallback? onLoginTap;
  final VoidCallback? onRegisterTap;

  const SegmentedAuthTabs({
    super.key,
    required this.activeIndex,
    this.onLoginTap,
    this.onRegisterTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.inputFill,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _TabItem(
            label: 'Iniciar sesión',
            isActive: activeIndex == 0,
            onTap: onLoginTap,
          ),
          _TabItem(
            label: 'Registrarse',
            isActive: activeIndex == 1,
            onTap: onRegisterTap,
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback? onTap;

  const _TabItem({
    required this.label,
    required this.isActive,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isActive ? AppColors.brandMid : Colors.transparent,
            borderRadius: BorderRadius.circular(26),
            boxShadow: isActive
                ? const [
                    BoxShadow(
                      color: Color(0x221E7A45),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: isActive ? AppColors.textOnGreen : AppColors.textPrimary,
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
