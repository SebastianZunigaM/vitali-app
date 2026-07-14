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
Eres un entrenador personal experto. Genera una rutina de ejercicios diaria personalizada en español.

Datos del usuario:
- Nombre: ${imc.name}
- Edad: ${imc.age} años
- Peso: ${imc.weight.toStringAsFixed(1)} kg
- Altura: ${imc.height.toStringAsFixed(2)} m
- IMC: ${imc.imc.toStringAsFixed(1)} (${imc.classification.label})
- Objetivo: ${imc.recommendedGoal}
- Estilo de vida: ${lifestyle.title}

Reglas importantes:
- Exactamente 5 ejercicios.
- Seguros y realistas para una app general de bienestar.
- Sin ejercicios peligrosos o de alto riesgo.
- Adaptados al IMC y estilo de vida del usuario.
- Intensidades permitidas: suave, moderada, alta (en minúscula, sin acentos).
- El campo "description" puede ser cadena vacía "" para ejercicios simples.
- Descripciones máximo 2 líneas si las hay.
- Texto completamente en español.
- Sin markdown. Sin ```. Solo JSON puro.

Responde ÚNICAMENTE con JSON válido. Sin texto adicional. Sin bloques markdown. Solo el JSON:
{
  "title": "Rutina de Ejercicios",
  "subtitle": "${lifestyle.title} · tipo de rutina",
  "recommendation": "consejo motivador breve, máximo 15 palabras",
  "exercises": [
    {
      "emoji": "🔥",
      "title": "nombre del ejercicio",
      "durationMinutes": 10,
      "intensity": "suave",
      "description": "descripción breve o cadena vacía"
    }
  ]
}
''';
}
