import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/daily_providers.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/shared/widgets/exercise_card.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/intensity_badge.dart';
import 'package:vitali/shared/widgets/metric_chip.dart';
import 'package:vitali/shared/widgets/section_header.dart';
import 'package:vitali/shared/widgets/vitali_app_bar.dart';
import 'package:vitali/shared/widgets/vitali_bottom_nav.dart';

/// Pantalla 12 + 13 — Rutina de Ejercicios (lista + detalle expandido).
/// Estado local mínimo: _expandedIndex controla qué tarjeta está abierta (acordeón).
/// Por defecto inicia con Circuito de fuerza expandido para mostrar el estado P13.
class ExercisePage extends ConsumerStatefulWidget {
  const ExercisePage({super.key});

  @override
  ConsumerState<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends ConsumerState<ExercisePage> {
  // Inicia con índice 2 expandido (Circuito de fuerza = estado P13)
  int? _expandedIndex = 2;

  static const _exercises = [
    _ExerciseData(
      emoji: '🔥',
      title: 'Calentamiento dinámico',
      duration: '10 min',
      intensity: ExerciseIntensity.moderate,
      description: null,
    ),
    _ExerciseData(
      emoji: '🏃',
      title: 'Carrera continua',
      duration: '30 min',
      intensity: ExerciseIntensity.high,
      description: null,
    ),
    _ExerciseData(
      emoji: '🏋️',
      title: 'Circuito de fuerza',
      duration: '20 min',
      intensity: ExerciseIntensity.high,
      description:
          'Sentadillas, lunges, flexiones y abdominales. '
          '4 ejercicios x 15 reps, 3 vueltas. Descanso 60 seg.',
    ),
    _ExerciseData(
      emoji: '⚡',
      title: 'HIIT corto',
      duration: '15 min',
      intensity: ExerciseIntensity.high,
      description: null,
    ),
    _ExerciseData(
      emoji: '🌊',
      title: 'Vuelta a la calma',
      duration: '10 min',
      intensity: ExerciseIntensity.soft,
      description: null,
    ),
  ];

  void _toggleExpanded(int index) {
    setState(() {
      _expandedIndex = _expandedIndex == index ? null : index;
    });
  }

  void _toggleCompleted(int index) {
    final current = ref.read(completedExercisesProvider);
    final updated = Set<int>.from(current);
    if (updated.contains(index)) {
      updated.remove(index);
    } else {
      updated.add(index);
    }
    ref.read(completedExercisesProvider.notifier).state = updated;
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final lifestyleTitle = session.lifestyle?.title ?? 'Deportista';
    final completedExercises = ref.watch(completedExercisesProvider);

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
                  // Encabezado de sección con chips de métricas
                  SectionHeader(
                    emoji: '🏃',
                    title: 'Rutina de Ejercicios',
                    subtitle: '$lifestyleTitle · Cardio y Fuerza',
                    bottomWidget: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          const MetricChip(
                            value: '85 min',
                            label: 'total',
                            icon: Icons.timer_outlined,
                          ),
                          const SizedBox(width: 8),
                          const MetricChip(
                            value: '5',
                            label: 'ejercicios',
                            icon: Icons.fitness_center_rounded,
                          ),
                          const SizedBox(width: 8),
                          MetricChip(
                            value: '${completedExercises.length}',
                            label: 'completados',
                            icon: Icons.check_circle_outline_rounded,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Tarjeta informativa pastel azul
                        const InfoPastelCard(
                          emoji: '💡',
                          title:
                              'Rutina equilibrada para mantener y mejorar tu forma',
                          backgroundColor: AppColors.infoPastel,
                          titleColor: AppColors.brandMid,
                        ),

                        const SizedBox(height: 12),

                        // Lista de ejercicios con estado acordeón
                        ...List.generate(_exercises.length, (i) {
                          final e = _exercises[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ExerciseCard(
                              emoji: e.emoji,
                              title: e.title,
                              duration: e.duration,
                              intensity: e.intensity,
                              isExpanded: _expandedIndex == i,
                              isCompleted: completedExercises.contains(i),
                              description: e.description,
                              onToggleExpanded: e.description != null
                                  ? () => _toggleExpanded(i)
                                  : null,
                              onCompletePressed: () => _toggleCompleted(i),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Navegación inferior — Ejercicio activo ────────────────────
          VitaliBottomNav(
            activeIndex: 1,
            onTap: (i) {
              if (i == 0) context.go(AppRoutes.nutrition);
              if (i == 2) context.go(AppRoutes.progress);
            },
          ),
        ],
      ),
    );
  }
}

/// Datos estáticos de cada ejercicio de la rutina.
class _ExerciseData {
  final String emoji;
  final String title;
  final String duration;
  final ExerciseIntensity intensity;
  final String? description;

  const _ExerciseData({
    required this.emoji,
    required this.title,
    required this.duration,
    required this.intensity,
    required this.description,
  });
}
