import 'package:vitali/features/onboarding/domain/models/imc_classification.dart';

/// Resultado completo del cálculo de IMC.
/// Creado por [ImcResultData.calculate] desde los inputs del formulario.
/// Pasado como [extra] en GoRouter de P04 → P05.
class ImcResultData {
  final String name;
  final int age;
  final double weight;
  final double height;
  final double imc;
  final ImcClassification classification;
  final String recommendedGoal;
  final String dailyRecommendation;

  const ImcResultData({
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
    required this.imc,
    required this.classification,
    required this.recommendedGoal,
    required this.dailyRecommendation,
  });

  /// Calcula el IMC a partir de los datos del formulario.
  factory ImcResultData.calculate({
    required String name,
    required int age,
    required double weight,
    required double height,
  }) {
    final raw = weight / (height * height);
    final imc = double.parse(raw.toStringAsFixed(1));

    final ImcClassification cls;
    if (imc < 18.5) {
      cls = ImcClassification.underweight;
    } else if (imc < 25.0) {
      cls = ImcClassification.healthy;
    } else if (imc < 30.0) {
      cls = ImcClassification.overweight;
    } else {
      cls = ImcClassification.obese;
    }

    return ImcResultData(
      name: name,
      age: age,
      weight: weight,
      height: height,
      imc: imc,
      classification: cls,
      recommendedGoal: _goalFor(cls),
      dailyRecommendation: _recommendationFor(cls),
    );
  }

  /// Datos de demostración usados cuando P05 se abre sin parámetros extra.
  static const fallback = ImcResultData(
    name: 'sebas',
    age: 19,
    weight: 90,
    height: 1.90,
    imc: 24.9,
    classification: ImcClassification.healthy,
    recommendedGoal: 'Mantener el peso',
    dailyRecommendation:
        'Incluye frutas y verduras de colores variados en cada comida.',
  );

  static String _goalFor(ImcClassification c) {
    switch (c) {
      case ImcClassification.underweight:
        return 'Aumentar masa de forma saludable';
      case ImcClassification.healthy:
        return 'Mantener el peso';
      case ImcClassification.overweight:
        return 'Reducir grasa corporal gradualmente';
      case ImcClassification.obese:
        return 'Mejorar composición corporal con acompañamiento';
    }
  }

  static String _recommendationFor(ImcClassification c) {
    switch (c) {
      case ImcClassification.underweight:
        return 'Aumenta tu ingesta de proteínas y calorías con alimentos nutritivos.';
      case ImcClassification.healthy:
        return 'Incluye frutas y verduras de colores variados en cada comida.';
      case ImcClassification.overweight:
        return 'Reduce las porciones de alimentos ultraprocesados y añade más fibra.';
      case ImcClassification.obese:
        return 'Consulta a un profesional de salud para un plan personalizado y seguro.';
    }
  }
}
