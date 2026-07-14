import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/daily_providers.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/ai/domain/models/exercise_routine_ai_result.dart';
import 'package:vitali/features/ai/presentation/providers/exercise_ai_provider.dart';
import 'package:vitali/shared/widgets/exercise_card.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/intensity_badge.dart';
import 'package:vitali/shared/widgets/metric_chip.dart';
import 'package:vitali/shared/widgets/section_header.dart';
import 'package:vitali/shared/widgets/vitali_app_bar.dart';
import 'package:vitali/shared/widgets/vitali_bottom_nav.dart';

/// Pantalla 12 + 13 — Rutina de Ejercicios.
/// Genera rutina personalizada con Gemini al primer acceso.
/// Fallback al plan mock si Gemini no está disponible o falla.
class ExercisePage extends ConsumerStatefulWidget {
  const ExercisePage({super.key});

  @override
  ConsumerState<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends ConsumerState<ExercisePage> {
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _triggerGeneration());
  }

  void _triggerGeneration() {
    final aiState = ref.read(exerciseAiProvider);
    if (aiState.hasGenerated || aiState.isLoading) return;
    final session = ref.read(sessionProvider);
    final imc = session.imcResult;
    final lifestyle = session.lifestyle;
    if (imc == null || lifestyle == null) return;
    ref.read(exerciseAiProvider.notifier).generate(imc, lifestyle);
  }

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

  static ExerciseIntensity _mapIntensity(String raw) {
    switch (raw.toLowerCase().trim()) {
      case 'suave':
        return ExerciseIntensity.soft;
      case 'alta':
        return ExerciseIntensity.high;
      default:
        return ExerciseIntensity.moderate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final lifestyleTitle = session.lifestyle?.title ?? 'Deportista';
    final completedExercises = ref.watch(completedExercisesProvider);

    final aiState = ref.watch(exerciseAiProvider);
    final routine = aiState.result ?? ExerciseRoutineAiResult.fallback;
    final exercises = routine.exercises;
    final totalMinutes =
        exercises.fold(0, (sum, e) => sum + e.durationMinutes);

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
                    subtitle: routine.subtitle.isNotEmpty
                        ? routine.subtitle
                        : '$lifestyleTitle · Cardio y Fuerza',
                    bottomWidget: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          MetricChip(
                            value: '$totalMinutes min',
                            label: 'total',
                            icon: Icons.timer_outlined,
                          ),
                          const SizedBox(width: 8),
                          MetricChip(
                            value: '${exercises.length}',
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
                        // Tarjeta informativa — usa recommendation de IA
                        InfoPastelCard(
                          emoji: '💡',
                          title: routine.recommendation.isNotEmpty
                              ? routine.recommendation
                              : 'Rutina equilibrada para mantener y mejorar tu forma',
                          backgroundColor: AppColors.infoPastel,
                          titleColor: AppColors.brandMid,
                        ),

                        // Indicador de estado IA (discreto)
                        if (aiState.isLoading) ...[
                          const SizedBox(height: 8),
                          const _AiStatusText(
                              'Generando rutina personalizada...'),
                        ] else if (aiState.errorMessage != null) ...[
                          const SizedBox(height: 8),
                          const _AiStatusText('Usando rutina base.'),
                        ],

                        const SizedBox(height: 12),

                        // Lista de ejercicios con estado acordeón
                        ...List.generate(exercises.length, (i) {
                          final e = exercises[i];
                          final hasDescription = e.description.isNotEmpty;
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: ExerciseCard(
                              emoji: e.emoji,
                              title: e.title,
                              duration: '${e.durationMinutes} min',
                              intensity: _mapIntensity(e.intensity),
                              isExpanded: _expandedIndex == i,
                              isCompleted: completedExercises.contains(i),
                              description:
                                  hasDescription ? e.description : null,
                              onToggleExpanded: hasDescription
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

/// Texto de estado IA — discreto, debajo de la tarjeta informativa.
class _AiStatusText extends StatelessWidget {
  final String text;
  const _AiStatusText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textHint,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
