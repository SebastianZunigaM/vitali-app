import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitali/core/services/gemini_service.dart';
import 'package:vitali/features/ai/data/ai_json_parser.dart';
import 'package:vitali/features/ai/data/ai_plan_repository.dart';
import 'package:vitali/features/ai/data/prompts/ai_prompts.dart';
import 'package:vitali/features/ai/domain/models/exercise_routine_ai_result.dart';
import 'package:vitali/features/onboarding/domain/models/imc_result_data.dart';
import 'package:vitali/features/onboarding/domain/models/lifestyle_option.dart';

class ExerciseAiState {
  final ExerciseRoutineAiResult? result;
  final bool isLoading;
  final bool hasGenerated;
  final String? errorMessage;

  const ExerciseAiState({
    this.result,
    this.isLoading = false,
    this.hasGenerated = false,
    this.errorMessage,
  });

  ExerciseAiState copyWith({
    ExerciseRoutineAiResult? result,
    bool? isLoading,
    bool? hasGenerated,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ExerciseAiState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      hasGenerated: hasGenerated ?? this.hasGenerated,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class ExerciseAiNotifier extends StateNotifier<ExerciseAiState> {
  final AiPlanRepository _repo;
  ExerciseAiNotifier(this._repo) : super(const ExerciseAiState());

  Future<void> generate(ImcResultData imc, LifestyleOption lifestyle) async {
    if (state.hasGenerated || state.isLoading) return;

    state = state.copyWith(isLoading: true, clearError: true);

    // ── Paso 1: buscar rutina guardada en Supabase ────────────────────────
    try {
      final cached = await _repo.getExerciseRoutine();
      if (cached != null && cached.exercises.isNotEmpty) {
        state = state.copyWith(
          result: cached,
          isLoading: false,
          hasGenerated: true,
          clearError: true,
        );
        return;
      }
    } catch (e) {
      debugPrint('[ExerciseAiNotifier] Cache load error: $e');
      // Continuar hacia Gemini
    }

    // ── Paso 2: generar con Gemini ────────────────────────────────────────
    try {
      final prompt = buildExercisePrompt(imc: imc, lifestyle: lifestyle);
      final raw = await GeminiService.generateText(prompt);
      final json = AiJsonParser.extractJsonObject(raw);

      if (json != null) {
        final result = ExerciseRoutineAiResult.fromJson(json);
        if (result.exercises.isNotEmpty) {
          // Guardar en Supabase sin bloquear la UI
          saveExerciseRoutineSilently(_repo, result);
          state = state.copyWith(
            result: result,
            isLoading: false,
            hasGenerated: true,
            clearError: true,
          );
          return;
        }
      }
      // JSON vacío o lista vacía — usar fallback (no guardar en Supabase)
      state = state.copyWith(
        result: ExerciseRoutineAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'Usando rutina base por ahora.',
      );
    } catch (e) {
      debugPrint('[ExerciseAiNotifier] Gemini error: $e');
      state = state.copyWith(
        result: ExerciseRoutineAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'Usando rutina base por ahora.',
      );
    }
  }

  void reset() => state = const ExerciseAiState();
}

final exerciseAiProvider =
    StateNotifierProvider<ExerciseAiNotifier, ExerciseAiState>(
  (ref) => ExerciseAiNotifier(ref.read(aiPlanRepositoryProvider)),
);
