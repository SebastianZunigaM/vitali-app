import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';

/// Encabezado de sección verde con emoji, título y subtítulo.
/// Aparece como primer elemento del contenido scrollable bajo VitaliAppBar.
/// Reutilizable en Alimentación (🥗), Ejercicio (🏃) y Progreso (📊).
/// [bottomWidget] opcional: aparece debajo del bloque emoji+título para
/// agregar chips de métricas u otro contenido dentro del mismo degradado verde.
class SectionHeader extends StatelessWidget {
  final String emoji;
  final String title;
  final String subtitle;
  final Widget? bottomWidget;

  const SectionHeader({
    super.key,
    required this.emoji,
    required this.title,
    required this.subtitle,
    this.bottomWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientHeader,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 26)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textOnGreen,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.textSlogan,
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (bottomWidget != null) ...[
            const SizedBox(height: 16),
            bottomWidget!,
          ],
        ],
      ),
    );
  }
}
