import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/core/services/supabase_service.dart';
import 'package:vitali/features/onboarding/domain/models/lifestyle_option.dart';
import 'package:vitali/features/profile/data/profile_repository.dart';
import 'package:vitali/features/profile/domain/models/profile_data.dart';
import 'package:vitali/shared/widgets/category_grid.dart';
import 'package:vitali/shared/widgets/feedback_banner.dart';
import 'package:vitali/shared/widgets/green_header.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/selectable_category_card.dart';
import 'package:vitali/shared/widgets/selection_summary_card.dart';

/// Pantalla 07 — Selección de Estilo de Vida: Estado Seleccionado.
/// Guarda el perfil completo en Supabase al confirmar el plan personalizado.
class LifestyleSelectedPage extends ConsumerStatefulWidget {
  final LifestyleOption? selectedLifestyle;

  const LifestyleSelectedPage({super.key, this.selectedLifestyle});

  @override
  ConsumerState<LifestyleSelectedPage> createState() =>
      _LifestyleSelectedPageState();
}

class _LifestyleSelectedPageState extends ConsumerState<LifestyleSelectedPage> {
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _saveAndContinue(LifestyleOption selected) async {
    final session = ref.read(sessionProvider);
    final imcData = session.imcResult;
    final lifestyle = session.lifestyle ?? selected;

    final user = SupabaseService.client.auth.currentUser;

    if (user == null) {
      setState(() =>
          _errorMessage = 'Debes iniciar sesión para guardar tu perfil.');
      return;
    }

    if (imcData == null) {
      setState(() => _errorMessage = 'Faltan datos del onboarding.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final profile = ProfileData.fromSession(
        userId: user.id,
        email: user.email ?? '',
        imc: imcData,
        lifestyle: lifestyle,
      );
      await ref.read(profileRepositoryProvider).upsertProfile(profile);
      if (mounted) context.go(AppRoutes.nutrition);
    } catch (_) {
      if (mounted) {
        setState(() =>
            _errorMessage =
                'No se pudo guardar tu perfil. Inténtalo de nuevo.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = widget.selectedLifestyle ?? LifestyleOption.fallback;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Cabecera verde ────────────────────────────────────────────
          GreenHeader(
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '¿Cómo es tu estilo de vida?',
                      style: TextStyle(
                        color: AppColors.textOnGreen,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Selecciona la categoría que mejor te describe',
                      style: TextStyle(
                        color: AppColors.textSlogan,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Contenido scrollable ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Grid 2×3 con la opción seleccionada resaltada
                  CategoryGrid(
                    items: LifestyleOption.all.map((opt) {
                      return SelectableCategoryCard(
                        emoji: opt.emoji,
                        title: opt.title,
                        description: opt.description,
                        isSelected: opt.id == selected.id,
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 16),

                  // Tarjeta de confirmación dinámica
                  SelectionSummaryCard(
                    emoji: selected.emoji,
                    value: selected.title,
                  ),

                  const SizedBox(height: 20),

                  // ── Feedback de error ─────────────────────────────────
                  if (_errorMessage != null) ...[
                    FeedbackBanner(
                      message: _errorMessage!,
                      type: FeedbackBannerType.error,
                    ),
                    const SizedBox(height: 12),
                  ],

                  // ── Botón / Loading ───────────────────────────────────
                  _isLoading
                      ? const SizedBox(
                          height: 50,
                          child: Center(
                            child: SizedBox(
                              width: 26,
                              height: 26,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: AppColors.brandMain,
                              ),
                            ),
                          ),
                        )
                      : PrimaryGradientButton(
                          label: 'Ver mi plan personalizado',
                          hasArrow: true,
                          onPressed: () => _saveAndContinue(selected),
                        ),

                  const SizedBox(height: 16),

                  // Tarjeta informativa azul pastel
                  const InfoPastelCard(
                    emoji: '✨',
                    title:
                        'Tu categoría personaliza tu plan de alimentación, rutina de ejercicios y recomendaciones de bienestar.',
                    backgroundColor: AppColors.infoPastel,
                    titleColor: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
