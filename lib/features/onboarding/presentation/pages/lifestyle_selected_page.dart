import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/shared/widgets/category_grid.dart';
import 'package:vitali/shared/widgets/green_header.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/selectable_category_card.dart';
import 'package:vitali/shared/widgets/selection_summary_card.dart';

/// Pantalla 07 — Selección de Estilo de Vida: Estado Seleccionado.
/// Muestra la categoría «Deportista» seleccionada, la tarjeta de confirmación
/// y el botón de acción habilitado. Datos estáticos para demo.
class LifestyleSelectedPage extends StatelessWidget {
  const LifestyleSelectedPage({super.key});

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
                  // Cuadrícula 2×3 — Deportista seleccionado
                  CategoryGrid(
                    items: const [
                      SelectableCategoryCard(
                        emoji: '📚',
                        title: 'Estudiante',
                        description: 'Paso varias horas sentado/a estudiando',
                      ),
                      SelectableCategoryCard(
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
                        isSelected: true,
                      ),
                      SelectableCategoryCard(
                        emoji: '🏆',
                        title: 'Atleta',
                        description:
                            'Entrenamiento intensivo diario o competitivo',
                      ),
                      SelectableCategoryCard(
                        emoji: '🌿',
                        title: 'Adulto mayor',
                        description: 'Busco mantener movilidad y bienestar',
                      ),
                      SelectableCategoryCard(
                        emoji: '🛋️',
                        title: 'Persona sedentaria',
                        description: 'Poco movimiento en mi rutina diaria',
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Tarjeta de confirmación de selección
                  const SelectionSummaryCard(
                    emoji: '🏃',
                    value: 'Deportista',
                  ),

                  const SizedBox(height: 20),

                  // Botón habilitado
                  PrimaryGradientButton(
                    label: 'Ver mi plan personalizado',
                    hasArrow: true,
                    onPressed: () => context.go(AppRoutes.nutrition),
                  ),

                  const SizedBox(height: 16),

                  // Tarjeta informativa azul pastel (sin cambios)
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

