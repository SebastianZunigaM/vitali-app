import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

class PrimaryGradientButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool hasArrow;
  final List<Color> gradientColors;

  const PrimaryGradientButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isEnabled = true,
    this.hasArrow = false,
    this.gradientColors = AppColors.gradientButtonPrimary,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled && onPressed != null;

    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: enabled
              ? LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                )
              : null,
          color: enabled ? null : AppColors.buttonDisabledBg,
          borderRadius: BorderRadius.circular(30),
          boxShadow: enabled
              ? const [
                  BoxShadow(
                    color: Color(0x332BA05F),
                    blurRadius: 14,
                    offset: Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(
                color: enabled ? AppColors.textOnGreen : AppColors.buttonDisabledText,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
            if (hasArrow) ...[
              const SizedBox(width: 4),
              Icon(
                Icons.chevron_right_rounded,
                color: enabled ? AppColors.textOnGreen : AppColors.buttonDisabledText,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
