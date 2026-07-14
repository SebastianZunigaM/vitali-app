/// Resultado de IA para la rutina de ejercicios personalizada.
class ExerciseRoutineAiResult {
  final String title;
  final String subtitle;
  final List<String> exercises;
  final String recommendation;

  const ExerciseRoutineAiResult({
    required this.title,
    required this.subtitle,
    required this.exercises,
    required this.recommendation,
  });

  factory ExerciseRoutineAiResult.fromJson(Map<String, dynamic> json) {
    List<String> toList(String key) {
      final raw = json[key];
      if (raw is List) return raw.map((e) => e.toString()).toList();
      return [];
    }

    return ExerciseRoutineAiResult(
      title: (json['title'] as String?) ?? '',
      subtitle: (json['subtitle'] as String?) ?? '',
      exercises: toList('exercises'),
      recommendation: (json['recommendation'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'exercises': exercises,
        'recommendation': recommendation,
      };
}
