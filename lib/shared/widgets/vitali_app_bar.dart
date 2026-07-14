import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/daily_providers.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/ai/presentation/providers/nutrition_ai_provider.dart';
import 'package:vitali/features/auth/data/auth_repository.dart';

/// Barra de aplicación superior del shell principal.
/// Muestra la marca compacta VITALI + isotipo y el botón Salir.
/// [onSalir] opcional: si no se provee, ejecuta signOut y navega a Login.
class VitaliAppBar extends ConsumerWidget {
  final VoidCallback? onSalir;

  const VitaliAppBar({super.key, this.onSalir});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> handleSalir() async {
      // 1. Cerrar sesión en Supabase
      try {
        await ref.read(authRepositoryProvider).signOut();
      } catch (_) {
        // Si no hay sesión activa, ignorar y continuar con la limpieza.
      }

      // 2. Limpiar sesión local, providers diarios y plan de IA
      ref.read(sessionProvider.notifier).state = const AppSessionData();
      ref.read(waterCountProvider.notifier).state = 0;
      ref.read(saltGramsProvider.notifier).state = 0;
      ref.read(sugarGramsProvider.notifier).state = 0;
      ref.read(completedExercisesProvider.notifier).state = const {};
      ref.read(manualHabitsProvider.notifier).state = const {};
      ref.read(nutritionAiProvider.notifier).reset();

      // 3. Navegar a Login
      if (context.mounted) context.go(AppRoutes.login);
    }

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.gradientHeader,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height: kToolbarHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Isotipo compacto
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: AppColors.brandForest,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.monitor_heart_outlined,
                    color: AppColors.textOnGreen,
                    size: 17,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'VITALI',
                  style: TextStyle(
                    color: AppColors.textOnGreen,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                const Spacer(),
                // Botón Salir — ejecuta signOut luego navega a Login
                GestureDetector(
                  onTap: onSalir ?? () => handleSalir(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.brandForest,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x33FFFFFF),
                        width: 1,
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.exit_to_app_rounded,
                          color: AppColors.textOnGreen,
                          size: 14,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Salir',
                          style: TextStyle(
                            color: AppColors.textOnGreen,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
