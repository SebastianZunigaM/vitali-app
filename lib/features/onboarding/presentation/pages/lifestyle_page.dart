import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/shared/widgets/category_grid.dart';
import 'package:vitali/shared/widgets/green_header.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/selectable_category_card.dart';

/// Pantalla 06 — Selección de Estilo de Vida.
/// Cuadrícula 2×3 de categorías seleccionables. Estado inicial: ninguna seleccionada.
class LifestylePage extends StatelessWidget {
  const LifestylePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  // Cuadrícula 2×3 de categorías
                  CategoryGrid(
                    items: [
                      const SelectableCategoryCard(
                        emoji: '📚',
                        title: 'Estudiante',
                        description: 'Paso varias horas sentado/a estudiando',
                      ),
                      const SelectableCategoryCard(
                        emoji: '💼',
                        title: 'Trabajador/a',
                        description:
                            'Mi jornada implica trabajo de oficina o físico',
                      ),
                      SelectableCategoryCard(
                        emoji: '🏃',
                        title: 'Deportista',
                        description:
                            'Hago ejercicio regularmente (4-5 días/semana)',
                        onTap: () => context.push(AppRoutes.lifestyleSelected),
                      ),
                      const SelectableCategoryCard(
                        emoji: '🏆',
                        title: 'Atleta',
                        description:
                            'Entrenamiento intensivo diario o competitivo',
                      ),
                      const SelectableCategoryCard(
                        emoji: '🌿',
                        title: 'Adulto mayor',
                        description: 'Busco mantener movilidad y bienestar',
                      ),
                      const SelectableCategoryCard(
                        emoji: '🛋️',
                        title: 'Persona sedentaria',
                        description: 'Poco movimiento en mi rutina diaria',
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Botón deshabilitado hasta seleccionar categoría
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
