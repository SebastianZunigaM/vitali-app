import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/shared/widgets/status_chip.dart';

/// Fila de indicador diario: emoji + label + stepper −/+ + chip de estado.
/// Retícula: [emoji][label] — [−][valor][+], chip de estado alineado abajo-izquierda.
/// Colores totalmente parametrizables para Agua, Sal y Azúcar.
/// Reutilizable en P08-09, futuros módulos de hidratación y progreso.
class DailyIndicatorRow extends StatelessWidget {
  final String emoji;
  final String label;
  final String valueText;
  final Color color;
  final Color pastelColor;
  final String statusText;
  final Color statusBg;
  final Color statusTextColor;
  final VoidCallback? onDecrement;
  final VoidCallback? onIncrement;

  const DailyIndicatorRow({
    super.key,
    required this.emoji,
    required this.label,
    required this.valueText,
    required this.color,
    required this.pastelColor,
    required this.statusText,
    required this.statusBg,
    required this.statusTextColor,
    this.onDecrement,
    this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Emoji del indicador
            Text(emoji, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 8),
            // Nombre del indicador
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // Stepper − / valor / +
            _StepperButton(
              icon: Icons.remove_rounded,
              color: color,
              pastelColor: pastelColor,
              onTap: onDecrement,
            ),
            const SizedBox(width: 10),
            Text(
              valueText,
              style: TextStyle(
                color: color,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 10),
            _StepperButton(
              icon: Icons.add_rounded,
              color: color,
              pastelColor: pastelColor,
              onTap: onIncrement,
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Chip de estado alineado bajo el label (no bajo el emoji)
        Padding(
          padding: const EdgeInsets.only(left: 26),
          child: StatusChip(
            text: statusText,
            backgroundColor: statusBg,
            textColor: statusTextColor,
          ),
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color pastelColor;
  final VoidCallback? onTap;

  const _StepperButton({
    required this.icon,
    required this.color,
    required this.pastelColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: onTap == null ? 0.4 : 1.0,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: pastelColor,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 18),
        ),
      ),
    );
  }
}
