import 'package:vitali/features/onboarding/domain/models/imc_classification.dart';
import 'package:vitali/features/onboarding/domain/models/imc_result_data.dart';
import 'package:vitali/features/onboarding/domain/models/lifestyle_option.dart';

/// Perfil completo del usuario guardado en Supabase.
class ProfileData {
  final String id;
  final String email;
  final String fullName;
  final int age;
  final double weightKg;
  final double heightM;
  final double imcValue;
  final String imcClassification;
  final String recommendedGoal;
  final String dailyRecommendation;
  final String lifestyleId;
  final String lifestyleTitle;
  final String lifestyleEmoji;

  const ProfileData({
    required this.id,
    required this.email,
    required this.fullName,
    required this.age,
    required this.weightKg,
    required this.heightM,
    required this.imcValue,
    required this.imcClassification,
    required this.recommendedGoal,
    required this.dailyRecommendation,
    required this.lifestyleId,
    required this.lifestyleTitle,
    required this.lifestyleEmoji,
  });

  /// Construye un ProfileData desde los datos de sesión local (onboarding).
  factory ProfileData.fromSession({
    required String userId,
    required String email,
    required ImcResultData imc,
    required LifestyleOption lifestyle,
  }) {
    return ProfileData(
      id: userId,
      email: email,
      fullName: imc.name,
      age: imc.age,
      weightKg: imc.weight,
      heightM: imc.height,
      imcValue: imc.imc,
      imcClassification: imc.classification.name,
      recommendedGoal: imc.recommendedGoal,
      dailyRecommendation: imc.dailyRecommendation,
      lifestyleId: lifestyle.id,
      lifestyleTitle: lifestyle.title,
      lifestyleEmoji: lifestyle.emoji,
    );
  }

  /// Convierte a JSON para enviar a Supabase.
  /// No incluye created_at — el default de la DB lo gestiona en el primer INSERT.
  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'full_name': fullName,
        'age': age,
        'weight_kg': weightKg,
        'height_m': heightM,
        'imc_value': imcValue,
        'imc_classification': imcClassification,
        'recommended_goal': recommendedGoal,
        'daily_recommendation': dailyRecommendation,
        'lifestyle_id': lifestyleId,
        'lifestyle_title': lifestyleTitle,
        'lifestyle_emoji': lifestyleEmoji,
        'updated_at': DateTime.now().toIso8601String(),
      };

  /// Reconstruye un ImcResultData desde los datos del perfil guardado en Supabase.
  ImcResultData toImcResultData() => ImcResultData(
        name: fullName,
        age: age,
        weight: weightKg,
        height: heightM,
        imc: imcValue,
        classification: ImcClassificationExt.fromName(imcClassification),
        recommendedGoal: recommendedGoal,
        dailyRecommendation: dailyRecommendation,
      );

  /// Reconstruye un LifestyleOption buscando por lifestyleId en la lista estática.
  /// Si no encuentra coincidencia, retorna LifestyleOption.fallback.
  LifestyleOption toLifestyleOption() {
    return LifestyleOption.all.firstWhere(
      (opt) => opt.id == lifestyleId,
      orElse: () => LifestyleOption.fallback,
    );
  }

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        id: json['id'] as String,
        email: json['email'] as String? ?? '',
        fullName: json['full_name'] as String? ?? '',
        age: json['age'] as int? ?? 0,
        weightKg: (json['weight_kg'] as num?)?.toDouble() ?? 0,
        heightM: (json['height_m'] as num?)?.toDouble() ?? 0,
        imcValue: (json['imc_value'] as num?)?.toDouble() ?? 0,
        imcClassification: json['imc_classification'] as String? ?? '',
        recommendedGoal: json['recommended_goal'] as String? ?? '',
        dailyRecommendation: json['daily_recommendation'] as String? ?? '',
        lifestyleId: json['lifestyle_id'] as String? ?? '',
        lifestyleTitle: json['lifestyle_title'] as String? ?? '',
        lifestyleEmoji: json['lifestyle_emoji'] as String? ?? '',
      );
}
