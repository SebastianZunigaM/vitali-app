import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vitali/core/services/gemini_service.dart';
import 'package:vitali/features/ai/data/ai_json_parser.dart';
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
  NutritionAiNotifier() : super(const NutritionAiState());

  Future<void> generate(ImcResultData imc, LifestyleOption lifestyle) async {
    if (state.hasGenerated || state.isLoading) return;

    state = state.copyWith(isLoading: true, clearError: true);

    try {
      final prompt = buildNutritionPrompt(imc: imc, lifestyle: lifestyle);
      final raw = await GeminiService.generateText(prompt);
      final json = AiJsonParser.extractJsonObject(raw);

      if (json != null) {
        final result = NutritionPlanAiResult.fromJson(json);
        // Validate that lists are non-empty before using AI result
        if (result.breakfastOptions.isNotEmpty &&
            result.lunchOptions.isNotEmpty &&
            result.dinnerOptions.isNotEmpty) {
          state = state.copyWith(
            result: result,
            isLoading: false,
            hasGenerated: true,
            clearError: true,
          );
          return;
        }
      }
      // Parsed but empty lists — use fallback
      state = state.copyWith(
        result: NutritionPlanAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'Usando plan base por ahora.',
      );
    } catch (e) {
      debugPrint('[NutritionAiNotifier] Error: $e');
      state = state.copyWith(
        result: NutritionPlanAiResult.fallback,
        isLoading: false,
        hasGenerated: true,
        errorMessage: 'Usando plan base por ahora.',
      );
    }
  }

  void reset() => state = const NutritionAiState();
}

final nutritionAiProvider =
    StateNotifierProvider<NutritionAiNotifier, NutritionAiState>(
  (ref) => NutritionAiNotifier(),
);
