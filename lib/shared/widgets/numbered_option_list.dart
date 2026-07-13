import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Lista numerada de opciones con círculos verdes pastel.
/// Cada ítem: círculo brandMid con número + texto en dos líneas.
/// Separados por divisores finos. Acepta lista dinámica.
/// Reutilizable en P08 (Desayuno), P10 (Almuerzo), P11 (Cena).
class NumberedOptionList extends StatelessWidget {
  final List<String> options;

  const NumberedOptionList({super.key, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (i) {
        return Column(
          children: [
            if (i > 0)
              const Divider(height: 1, thickness: 0.8, color: AppColors.imcMuted),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Número en círculo verde pastel
                  Container(
                    width: 28,
                    height: 28,
                    decoration: const BoxDecoration(
                      color: AppColors.successBg,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: AppColors.brandMid,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Texto de la opción
                  Expanded(
                    child: Text(
                      options[i],
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
