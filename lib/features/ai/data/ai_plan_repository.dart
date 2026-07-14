import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitali/core/services/supabase_service.dart';
import 'package:vitali/features/ai/domain/models/exercise_routine_ai_result.dart';
import 'package:vitali/features/ai/domain/models/nutrition_plan_ai_result.dart';

/// Repositorio para persistir y cargar planes IA en la tabla public.ai_plans.
/// Cada usuario tiene exactamente una fila identificada por su UUID.
/// Usa upsert — nutrition_plan y exercise_routine se actualizan de forma independiente.
class AiPlanRepository {
  final SupabaseClient _client;
  const AiPlanRepository(this._client);

  // ── Nutrición ─────────────────────────────────────────────────────────────

  Future<NutritionPlanAiResult?> getNutritionPlan() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final response = await _client
        .from('ai_plans')
        .select('nutrition_plan')
        .eq('id', user.id)
        .maybeSingle();

    final data = response?['nutrition_plan'];
    if (data is Map<String, dynamic>) {
      return NutritionPlanAiResult.fromJson(data);
    }
    return null;
  }

  Future<void> saveNutritionPlan(NutritionPlanAiResult plan) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('ai_plans').upsert({
      'id': user.id,
      'nutrition_plan': plan.toJson(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }

  // ── Ejercicios ────────────────────────────────────────────────────────────

  Future<ExerciseRoutineAiResult?> getExerciseRoutine() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final response = await _client
        .from('ai_plans')
        .select('exercise_routine')
        .eq('id', user.id)
        .maybeSingle();

    final data = response?['exercise_routine'];
    if (data is Map<String, dynamic>) {
      return ExerciseRoutineAiResult.fromJson(data);
    }
    return null;
  }

  Future<void> saveExerciseRoutine(ExerciseRoutineAiResult routine) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('ai_plans').upsert({
      'id': user.id,
      'exercise_routine': routine.toJson(),
      'updated_at': DateTime.now().toIso8601String(),
    });
  }
}

final aiPlanRepositoryProvider = Provider<AiPlanRepository>(
  (ref) => AiPlanRepository(SupabaseService.client),
);

/// Guarda silenciosamente ignorando errores — no bloquea la UI.
void saveNutritionPlanSilently(
  AiPlanRepository repo,
  NutritionPlanAiResult plan,
) {
  repo.saveNutritionPlan(plan).catchError((Object e) {
    debugPrint('[AiPlanRepository] saveNutritionPlan error: $e');
  });
}

void saveExerciseRoutineSilently(
  AiPlanRepository repo,
  ExerciseRoutineAiResult routine,
) {
  repo.saveExerciseRoutine(routine).catchError((Object e) {
    debugPrint('[AiPlanRepository] saveExerciseRoutine error: $e');
  });
}
