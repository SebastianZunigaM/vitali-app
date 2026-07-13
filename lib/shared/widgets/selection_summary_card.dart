import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Tarjeta de confirmación de selección: emoji + etiqueta + valor.
/// Aparece tras seleccionar una opción en cualquier flujo de elección.
/// Reutilizable en Perfil, Configuración y otros flujos de selección.
class SelectionSummaryCard extends StatelessWidget {
  final String emoji;
  final String value;
  final String label;

  const SelectionSummaryCard({
    super.key,
    required this.emoji,
    required this.value,
    this.label = 'Seleccionaste',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FBF9),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.imcMuted, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
