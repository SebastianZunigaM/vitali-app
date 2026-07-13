import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/shared/widgets/content_card.dart';
import 'package:vitali/shared/widgets/gradient_progress_bar.dart';
import 'package:vitali/shared/widgets/habit_checklist_item.dart';
import 'package:vitali/shared/widgets/progress_ring.dart';
import 'package:vitali/shared/widgets/quote_card.dart';
import 'package:vitali/shared/widgets/section_header.dart';
import 'package:vitali/shared/widgets/vitali_app_bar.dart';
import 'package:vitali/shared/widgets/vitali_bottom_nav.dart';
import 'package:vitali/shared/widgets/week_days_tracker.dart';

/// Pantalla 14 — Mi Progreso.
/// Muestra frase motivacional, checklist de hábitos de hoy con anillo de
/// porcentaje y racha semanal con barra de progreso.
class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  static const _habits = [
    _HabitData('💧', 'Agua (8 vasos)'),
    _HabitData('🏃', 'Ejercicio del día'),
    _HabitData('😴', 'Dormir 7h+'),
    _HabitData('🥗', 'Comer vegetales'),
    _HabitData('🧘', 'Pausa de relajación'),
  ];

  static const _weekLabels = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
  static const _weekCompleted = [true, true, true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Barra de aplicación ───────────────────────────────────────
          const VitaliAppBar(),

          // ── Contenido scrollable ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Encabezado de sección
                  const SectionHeader(
                    emoji: '📊',
                    title: 'Mi Progreso',
                    subtitle: 'sebas · Deportista',
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Frase de la semana ────────────────────────
                        const QuoteCard(
                          label: '✨ FRASE DE LA SEMANA',
                          quote:
                              '"Cuida tu cuerpo. Es el único lugar que tienes para vivir."',
                          author: '— Jim Rohn',
                        ),

                        const SizedBox(height: 12),

                        // ── Hábitos de hoy ────────────────────────────
                        ContentCard(
                          title: 'Hábitos de hoy',
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Anillo de progreso
                              const ProgressRing(
                                progress: 0.0,
                                centerLabel: '0%',
                              ),
                              const SizedBox(width: 16),
                              // Checklist de hábitos
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: _buildHabitList(),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ── Progreso semanal ──────────────────────────
                        ContentCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Título + contador
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'Progreso semanal',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '3/7 días',
                                    style: TextStyle(
                                      color: AppColors.brandMain,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              // Fila de días
                              const WeekDaysTracker(
                                dayLabels: _weekLabels,
                                dayCompleted: _weekCompleted,
                              ),
                              const SizedBox(height: 12),
                              // Barra de progreso degradada
                              const GradientProgressBar(
                                progress: 3 / 7,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Navegación inferior — Progreso activo ─────────────────────
          VitaliBottomNav(
            activeIndex: 2,
            onTap: (i) {
              if (i == 0) context.go(AppRoutes.nutrition);
              if (i == 1) context.go(AppRoutes.exercise);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _buildHabitList() {
    final widgets = <Widget>[];
    for (var i = 0; i < _habits.length; i++) {
      if (i > 0) {
        widgets.add(const Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Divider(
            height: 1,
            thickness: 0.8,
            color: AppColors.imcMuted,
          ),
        ));
      }
      widgets.add(HabitChecklistItem(
        emoji: _habits[i].emoji,
        label: _habits[i].label,
        isChecked: false,
      ));
    }
    return widgets;
  }
}

class _HabitData {
  final String emoji;
  final String label;
  const _HabitData(this.emoji, this.label);
}
