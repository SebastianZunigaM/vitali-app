import 'package:vitali/features/onboarding/domain/models/imc_classification.dart';
import 'package:vitali/features/onboarding/domain/models/imc_result_data.dart';
import 'package:vitali/features/onboarding/domain/models/lifestyle_option.dart';

/// Prompts base para las llamadas a Gemini.
/// Cada función retorna un String listo para enviar a GeminiService.generateText().
/// Las respuestas se solicitan en JSON estricto para facilitar el parsing.

String buildNutritionPrompt({
  required ImcResultData imc,
  required LifestyleOption lifestyle,
}) {
  return '''
Eres un nutricionista experto. Genera un plan de alimentación diario personalizado en español para una persona costarricense.

Datos del usuario:
- Nombre: ${imc.name}
- Edad: ${imc.age} años
- Peso: ${imc.weight.toStringAsFixed(1)} kg
- Altura: ${imc.height.toStringAsFixed(2)} m
- IMC: ${imc.imc.toStringAsFixed(1)} (${imc.classification.label})
- Objetivo: ${imc.recommendedGoal}
- Recomendación: ${imc.dailyRecommendation}
- Estilo de vida: ${lifestyle.title}

Reglas importantes:
- Usa alimentos accesibles en Costa Rica.
- Cada opción debe ser un plato concreto, saludable y con porciones razonables.
- Adapta las opciones al objetivo y estilo de vida del usuario.
- No hagas recomendaciones médicas. Solo opciones alimenticias.
- Cada opción debe caber en una línea corta (máximo 12 palabras).

Responde ÚNICAMENTE con JSON válido. Sin texto adicional. Sin bloques markdown. Sin explicaciones. Solo el JSON:
{
  "breakfastOptions": ["opción 1", "opción 2", "opción 3"],
  "lunchOptions": ["opción 1", "opción 2", "opción 3"],
  "dinnerOptions": ["opción 1", "opción 2", "opción 3"],
  "dailyTip": "consejo nutricional breve y motivador, máximo 20 palabras"
}
''';
}

String buildExercisePrompt({
  required ImcResultData imc,
  required LifestyleOption lifestyle,
}) {
  return '''
Eres un entrenador personal experto. Genera una rutina de ejercicios personalizada en español.

Datos del usuario:
- IMC: ${imc.imc.toStringAsFixed(1)} (${imc.classification.label})
- Objetivo recomendado: ${imc.recommendedGoal}
- Estilo de vida: ${lifestyle.title}

Responde ÚNICAMENTE con JSON válido, sin texto adicional, con esta estructura exacta:
{
  "title": "nombre corto de la rutina",
  "subtitle": "descripción breve de 1 línea",
  "exercises": ["ejercicio 1 con duración", "ejercicio 2 con duración", "ejercicio 3 con duración", "ejercicio 4 con duración"],
  "recommendation": "consejo motivador breve para el usuario"
}

La rutina debe ser realista, segura y adaptada al IMC y nivel de actividad del usuario.
''';
}
