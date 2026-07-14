import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/profile/data/profile_repository.dart';

/// Auth Gate — primera pantalla de la app.
/// Verifica sesión Supabase y decide el destino inicial:
///   sin sesión         → Login
///   sesión + profile   → NutritionPage (restaura sessionProvider)
///   sesión sin profile → ImcFormPage
///   error              → Login (seguro)
class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkAuth());
  }

  Future<void> _checkAuth() async {
    final user = Supabase.instance.client.auth.currentUser;

    if (!mounted) return;

    if (user == null) {
      context.go(AppRoutes.login);
      return;
    }

    try {
      final profile =
          await ref.read(profileRepositoryProvider).getCurrentProfile();
      if (!mounted) return;

      if (profile != null) {
        ref.read(sessionProvider.notifier).state = AppSessionData(
          imcResult: profile.toImcResultData(),
          lifestyle: profile.toLifestyleOption(),
        );
        context.go(AppRoutes.nutrition);
      } else {
        context.go(AppRoutes.imcForm);
      }
    } catch (e) {
      debugPrint('[SplashPage] Error cargando perfil: $e');
      if (mounted) context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.gradientAuth,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Isotipo
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppColors.brandForest,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: const Icon(
                    Icons.monitor_heart_outlined,
                    color: AppColors.textOnGreen,
                    size: 34,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'VITALI',
                  style: TextStyle(
                    color: AppColors.textOnGreen,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 8,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Cargando tu bienestar...',
                  style: TextStyle(
                    color: AppColors.textSlogan,
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 48),
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.textOnGreen,
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
