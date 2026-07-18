import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitali/core/services/gemini_service.dart';
import 'package:vitali/features/ai/data/ai_json_parser.dart';
import 'package:vitali/features/ai/data/ai_plan_repository.dart';
import 'package:vitali/features/ai/data/prompts/ai_prompts.dart';
import 'package:vitali/features/ai/domain/models/nutrition_plan_ai_result.dart';
import 'package:vitali/features/onboarding/domain/models/imc_result_data.dart';
import 'package:vitali/features/onboarding/domain/models/lifestyle_option.dart';

class NutritionAiState {
  final NutritionPlanAiResult? result;
  final bool isLoading;
  final bool hasGenerated;
  final String? errorMessage;

  const NutritionAiState({
    this.result,
    this.isLoading = false,
    this.hasGenerated = false,
    this.errorMessage,
  });

  NutritionAiState copyWith({
    NutritionPlanAiResult? result,
    bool? isLoading,
    bool? hasGenerated,
    String? errorMessage,
    bool clearError = false,
  }) {
    return NutritionAiState(
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
      hasGenerated: hasGenerated ?? this.hasGenerated,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

class NutritionAiNotifier extends StateNotifier<NutritionAiState> {
  final AiPlanRepository _repo;
  NutritionAiNotifier(this._repo) : super(const NutritionAiState());

  Future<void> generate(ImcResultData imc, LifestyleOption lifestyle) async {
    if (state.hasGenerated || state.isLoading) return;

    state = state.copyWith(isLoading: true, clearError: true);

    // ── Paso 1: buscar plan guardado en Supabase ──────────────────────────
    try {
      final cached = await _repo.getNutritionPlan();
      if (cached != null &&
          cached.breakfastOptions.isNotEmpty &&
          cached.lunchOptions.isNotEmpty &&
          cached.dinnerOptions.isNotEmpty) {
        state = state.copyWith(
          result: cached,
          isLoading: false,
          hasGenerated: true,
          clearError: true,
        );
        return;
      }
    } catch (e) {
      debugPrint('[NutritionAiNotifier] Cache load error: $e');
      // Continuar hacia Gemini
    }

    // ── Paso 2: generar con Gemini ────────────────────────────────────────
    try {
      final prompt = buildNutritionPrompt(imc: imc, lifestyle: lifestyle);
      final raw = await GeminiService.generateText(prompt);
      final json = AiJsonParser.extractJsonObject(raw);

      if (json != null) {
        final result = NutritionPlanAiResult.fromJson(json);
        if (result.breakfastOptions.isNotEmpty &&
            result.lunchOptions.isNotEmpty &&
            result.dinnerOptions.isNotEmpty) {
          // Guardar en Supabase sin bloquear la UI
          saveNutritionPlanSilently(_repo, result);
          state = state.copyWith(
            result: result,
            isLoading: false,
            hasGenerated: true,
            clearError: true,
          );
          return;
        }
      }
      // JSON vacío o listas vacías — usar fallback (no guardar en Supabase)
      state = state.copyWith(
        result: NutritionPlanAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'Usando plan base por ahora.',
      );
    } catch (e) {
      debugPrint('[NutritionAiNotifier] Gemini error: $e');
      state = state.copyWith(
        result: NutritionPlanAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'Usando plan base por ahora.',
      );
    }
  }

  /// Regenera el plan ignorando caché — siempre llama Gemini.
  /// Conserva el plan anterior si falla.
  Future<void> regenerate(ImcResultData imc, LifestyleOption lifestyle) async {
    if (state.isLoading) return;

    final previousResult = state.result;
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final prompt = buildNutritionPrompt(
        imc: imc,
        lifestyle: lifestyle,
        avoidRepeating: true,
      );
      final raw = await GeminiService.generateText(prompt);
      final json = AiJsonParser.extractJsonObject(raw);

      if (json != null) {
        final result = NutritionPlanAiResult.fromJson(json);
        if (result.breakfastOptions.isNotEmpty &&
            result.lunchOptions.isNotEmpty &&
            result.dinnerOptions.isNotEmpty) {
          saveNutritionPlanSilently(_repo, result);
          state = state.copyWith(
            result: result,
            isLoading: false,
            hasGenerated: true,
            clearError: true,
          );
          return;
        }
      }
      // No se obtuvo resultado válido — conservar plan anterior
      state = state.copyWith(
        result: previousResult ?? NutritionPlanAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'No se pudo generar otro plan. Inténtalo de nuevo.',
      );
    } catch (e) {
      debugPrint('[NutritionAiNotifier] Regenerate error: $e');
      state = state.copyWith(
        result: previousResult ?? NutritionPlanAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'No se pudo generar otro plan. Inténtalo de nuevo.',
      );
    }
  }

  void reset() => state = const NutritionAiState();
}

final nutritionAiProvider =
    StateNotifierProvider<NutritionAiNotifier, NutritionAiState>(
  (ref) => NutritionAiNotifier(ref.read(aiPlanRepositoryProvider)),
);
