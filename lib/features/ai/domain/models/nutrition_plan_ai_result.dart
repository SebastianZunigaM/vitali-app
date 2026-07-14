/// Resultado de IA para el plan de alimentación diario.
class NutritionPlanAiResult {
  final List<String> breakfastOptions;
  final List<String> lunchOptions;
  final List<String> dinnerOptions;
  final String dailyTip;

  const NutritionPlanAiResult({
    required this.breakfastOptions,
    required this.lunchOptions,
    required this.dinnerOptions,
    required this.dailyTip,
  });

  factory NutritionPlanAiResult.fromJson(Map<String, dynamic> json) {
    List<String> toList(String key) {
      final raw = json[key];
      if (raw is List) return raw.map((e) => e.toString()).toList();
      return [];
    }

    return NutritionPlanAiResult(
      breakfastOptions: toList('breakfastOptions'),
      lunchOptions: toList('lunchOptions'),
      dinnerOptions: toList('dinnerOptions'),
      dailyTip: (json['dailyTip'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'breakfastOptions': breakfastOptions,
        'lunchOptions': lunchOptions,
        'dinnerOptions': dinnerOptions,
        'dailyTip': dailyTip,
      };

  static const fallback = NutritionPlanAiResult(
    breakfastOptions: [
      'Batido de proteína con banana y mantequilla de maní',
      'Avena con proteína en polvo y frutas del bosque',
      'Huevos revueltos con espinaca, tomate y pan integral',
    ],
    lunchOptions: [
      'Arroz integral con pechuga de pollo y vegetales al vapor',
      'Pasta integral con carne magra y salsa de tomate natural',
      'Bowl de quinoa con salmón, aguacate y pepino',
    ],
    dinnerOptions: [
      'Pechuga de pavo con camote y ensalada',
      'Atún con arroz integral y brócoli',
      'Sopa de lentejas con pan de centeno',
    ],
    dailyTip:
        'Mastica lentamente y disfruta cada bocado. Comer despacio mejora la digestión y ayuda a reconocer la saciedad.',
  );
}
