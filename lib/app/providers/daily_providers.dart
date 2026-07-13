import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Water glasses consumed today (0–10).
final waterCountProvider = StateProvider<int>((ref) => 0);

/// Salt consumed today in grams (0–6, step 1).
final saltGramsProvider = StateProvider<int>((ref) => 0);

/// Sugar consumed today in grams (0–35, step 5).
final sugarGramsProvider = StateProvider<int>((ref) => 0);

/// Indices of exercises marked as completed this session.
final completedExercisesProvider = StateProvider<Set<int>>((ref) => const {});

/// Manually toggled habit indices (2=sleep, 3=veggies, 4=relaxation).
/// Habits 0 (water) and 1 (exercise) are auto-computed from other providers.
final manualHabitsProvider = StateProvider<Set<int>>((ref) => const {});
