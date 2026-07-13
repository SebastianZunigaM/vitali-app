/// Categoría de estilo de vida seleccionable.
/// Fuente única de verdad compartida entre LifestylePage y LifestyleSelectedPage.
class LifestyleOption {
  final String id;
  final String emoji;
  final String title;
  final String description;

  const LifestyleOption({
    required this.id,
    required this.emoji,
    required this.title,
    required this.description,
  });

  /// Lista completa de opciones del PDF — orden del grid 2×3.
  static const all = [
    LifestyleOption(
      id: 'student',
      emoji: '📚',
      title: 'Estudiante',
      description: 'Paso varias horas sentado/a estudiando',
    ),
    LifestyleOption(
      id: 'worker',
      emoji: '💼',
      title: 'Trabajador/a',
      description: 'Mi jornada implica trabajo de oficina o físico',
    ),
    LifestyleOption(
      id: 'athlete',
      emoji: '🏃',
      title: 'Deportista',
      description: 'Hago ejercicio regularmente (4-5 días/semana)',
    ),
    LifestyleOption(
      id: 'elite',
      emoji: '🏆',
      title: 'Atleta',
      description: 'Entrenamiento intensivo diario o competitivo',
    ),
    LifestyleOption(
      id: 'senior',
      emoji: '🌿',
      title: 'Adulto mayor',
      description: 'Busco mantener movilidad y bienestar',
    ),
    LifestyleOption(
      id: 'sedentary',
      emoji: '🛋️',
      title: 'Persona sedentaria',
      description: 'Poco movimiento en mi rutina diaria',
    ),
  ];

  /// Fallback para demo visual directa de Pantalla 07.
  static const fallback = LifestyleOption(
    id: 'athlete',
    emoji: '🏃',
    title: 'Deportista',
    description: 'Hago ejercicio regularmente (4-5 días/semana)',
  );
}
