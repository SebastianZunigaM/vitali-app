/// Ejercicio individual dentro de una rutina generada por IA.
class ExerciseAiItem {
  final String emoji;
  final String title;
  final int durationMinutes;
  final String intensity; // "suave" | "moderada" | "alta"
  final String description;

  const ExerciseAiItem({
    required this.emoji,
    required this.title,
    required this.durationMinutes,
    required this.intensity,
    required this.description,
  });

  factory ExerciseAiItem.fromJson(Map<String, dynamic> json) {
    // durationMinutes puede venir como int o como String desde la IA
    final rawDuration = json['durationMinutes'];
    final duration = rawDuration is int
        ? rawDuration
        : int.tryParse(rawDuration?.toString() ?? '') ?? 15;

    return ExerciseAiItem(
      emoji: (json['emoji'] as String?) ?? '💪',
      title: (json['title'] as String?) ?? '',
      durationMinutes: duration,
      intensity: (json['intensity'] as String?) ?? 'moderada',
      description: (json['description'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'emoji': emoji,
        'title': title,
        'durationMinutes': durationMinutes,
        'intensity': intensity,
        'description': description,
      };
}

/// Resultado de IA para la rutina de ejercicios personalizada.
class ExerciseRoutineAiResult {
  final String title;
  final String subtitle;
  final String recommendation;
  final List<ExerciseAiItem> exercises;

  const ExerciseRoutineAiResult({
    required this.title,
    required this.subtitle,
    required this.recommendation,
    required this.exercises,
  });

  factory ExerciseRoutineAiResult.fromJson(Map<String, dynamic> json) {
    final rawList = json['exercises'];
    final items = <ExerciseAiItem>[];
    if (rawList is List) {
      for (final e in rawList) {
        if (e is Map<String, dynamic>) items.add(ExerciseAiItem.fromJson(e));
      }
    }
    return ExerciseRoutineAiResult(
      title: (json['title'] as String?) ?? '',
      subtitle: (json['subtitle'] as String?) ?? '',
      recommendation: (json['recommendation'] as String?) ?? '',
      exercises: items,
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'subtitle': subtitle,
        'recommendation': recommendation,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };

  static const fallback = ExerciseRoutineAiResult(
    title: 'Rutina de Ejercicios',
    subtitle: 'Cardio y Fuerza',
    recommendation: 'Rutina equilibrada para mantener y mejorar tu forma',
    exercises: [
      ExerciseAiItem(
        emoji: '🔥',
        title: 'Calentamiento dinámico',
        durationMinutes: 10,
        intensity: 'suave',
        description: '',
      ),
      ExerciseAiItem(
        emoji: '🏃',
        title: 'Carrera continua',
        durationMinutes: 30,
        intensity: 'moderada',
        description: '',
      ),
      ExerciseAiItem(
        emoji: '🏋️',
        title: 'Circuito de fuerza',
        durationMinutes: 20,
        intensity: 'alta',
        description:
            'Sentadillas, lunges, flexiones y abdominales. '
            '4 ejercicios x 15 reps, 3 vueltas. Descanso 60 seg.',
      ),
      ExerciseAiItem(
        emoji: '⚡',
        title: 'HIIT corto',
        durationMinutes: 15,
        intensity: 'alta',
        description: '',
      ),
      ExerciseAiItem(
        emoji: '🌊',
        title: 'Vuelta a la calma',
        durationMinutes: 10,
        intensity: 'suave',
        description: '',
      ),
    ],
  );
}
