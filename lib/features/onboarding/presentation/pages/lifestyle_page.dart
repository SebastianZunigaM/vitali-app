import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/onboarding/domain/models/lifestyle_option.dart';
import 'package:vitali/shared/widgets/category_grid.dart';
import 'package:vitali/shared/widgets/green_header.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/selectable_category_card.dart';

/// Pantalla 06 — Selección de Estilo de Vida.
/// Grid 2×3 generado desde LifestyleOption.all.
/// Tocar cualquier tarjeta navega a P07 con la opción seleccionada como extra.
class LifestylePage extends ConsumerWidget {
  const LifestylePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Cabecera verde ────────────────────────────────────────────
          GreenHeader(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '¿Cómo es tu estilo de vida?',
                      style: TextStyle(
                        color: AppColors.textOnGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Selecciona la categoría que mejor te describe',
                      style: TextStyle(
                        color: AppColors.textSlogan,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Contenido scrollable ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Grid 2×3 generado desde la fuente de datos tipada
                  CategoryGrid(
                    items: LifestyleOption.all.map((opt) {
                      return SelectableCategoryCard(
                        emoji: opt.emoji,
                        title: opt.title,
                        description: opt.description,
                        onTap: () {
                          ref.read(sessionProvider.notifier).state =
                              ref.read(sessionProvider).copyWith(lifestyle: opt);
                          context.push(AppRoutes.lifestyleSelected, extra: opt);
                        },
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 24),

                  // Botón deshabilitado — se habilita en P07 tras confirmar
                  const PrimaryGradientButton(
                    label: 'Ver mi plan personalizado',
                    hasArrow: true,
                    isEnabled: false,
                    onPressed: null,
                  ),

                  const SizedBox(height: 16),

                  // Tarjeta informativa azul pastel
                  const InfoPastelCard(
                    emoji: '✨',
                    title:
                        'Tu categoría personaliza tu plan de alimentación, rutina de ejercicios y recomendaciones de bienestar.',
                    backgroundColor: AppColors.infoPastel,
                    titleColor: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
