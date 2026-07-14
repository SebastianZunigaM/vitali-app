import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/daily_providers.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/ai/domain/models/nutrition_plan_ai_result.dart';
import 'package:vitali/features/ai/presentation/providers/nutrition_ai_provider.dart';
import 'package:vitali/shared/widgets/content_card.dart';
import 'package:vitali/shared/widgets/daily_indicator_row.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/meal_tabs_selector.dart';
import 'package:vitali/shared/widgets/numbered_option_list.dart';
import 'package:vitali/shared/widgets/section_header.dart';
import 'package:vitali/shared/widgets/vitali_app_bar.dart';
import 'package:vitali/shared/widgets/vitali_bottom_nav.dart';

/// Pantalla 08+09+10 — Plan de Alimentación.
/// Genera opciones personalizadas con Gemini al primer acceso.
/// Fallback al plan base si Gemini no está disponible o falla.
class NutritionPage extends ConsumerStatefulWidget {
  const NutritionPage({super.key});

  @override
  ConsumerState<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends ConsumerState<NutritionPage> {
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _triggerGeneration());
  }

  void _triggerGeneration() {
    final aiState = ref.read(nutritionAiProvider);
    if (aiState.hasGenerated || aiState.isLoading) return;
    final session = ref.read(sessionProvider);
    final imc = session.imcResult;
    final lifestyle = session.lifestyle;
    if (imc == null || lifestyle == null) return;
    ref.read(nutritionAiProvider.notifier).generate(imc, lifestyle);
  }

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final lifestyleTitle = session.lifestyle?.title ?? 'Deportista';
    final water = ref.watch(waterCountProvider);
    final salt = ref.watch(saltGramsProvider);
    final sugar = ref.watch(sugarGramsProvider);

    final aiState = ref.watch(nutritionAiProvider);
    final plan = aiState.result ?? NutritionPlanAiResult.fallback;
    final mealOptions = [
      plan.breakfastOptions,
      plan.lunchOptions,
      plan.dinnerOptions,
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // ── Barra de aplicación ───────────────────────────────────────
          const VitaliAppBar(),

          // ── Contenido scrollable ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Encabezado de sección (scrollable)
                  SectionHeader(
                    emoji: '🥗',
                    title: 'Plan de Alimentación',
                    subtitle: 'Personalizado para $lifestyleTitle',
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Selector de comidas
                        MealTabsSelector(
                          activeIndex: _activeTab,
                          onTabChanged: (i) => setState(() => _activeTab = i),
                        ),

                        const SizedBox(height: 12),

                        // Tarjeta "Opciones para hoy" — cambia con el tab activo
                        ContentCard(
                          title: 'Opciones para hoy',
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Indicador de estado IA (discreto)
                              if (aiState.isLoading) ...[
                                const _AiStatusText(
                                    'Generando plan personalizado...'),
                                const SizedBox(height: 8),
                              ] else if (aiState.errorMessage != null) ...[
                                const _AiStatusText('Usando plan base.'),
                                const SizedBox(height: 8),
                              ],
                              NumberedOptionList(
                                options: mealOptions[_activeTab],
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Tarjeta "Indicadores diarios"
                        ContentCard(
                          title: '📊 Indicadores diarios',
                          child: Column(
                            children: [
                              DailyIndicatorRow(
                                emoji: '💧',
                                label: 'Agua',
                                valueText: '$water/10 vasos',
                                color: AppColors.water,
                                pastelColor: AppColors.waterPastel,
                                statusText: water >= 10
                                    ? '✅ Meta de agua alcanzada'
                                    : '${10 - water} vasos más para llegar a tu meta',
                                statusBg: water >= 10
                                    ? AppColors.successBg
                                    : AppColors.waterPastel,
                                statusTextColor: water >= 10
                                    ? AppColors.successText
                                    : AppColors.water,
                                onDecrement: water > 0
                                    ? () => ref
                                        .read(waterCountProvider.notifier)
                                        .state--
                                    : null,
                                onIncrement: water < 10
                                    ? () => ref
                                        .read(waterCountProvider.notifier)
                                        .state++
                                    : null,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Divider(
                                  height: 1,
                                  thickness: 0.8,
                                  color: AppColors.imcMuted,
                                ),
                              ),
                              DailyIndicatorRow(
                                emoji: '🧂',
                                label: 'Sal',
                                valueText: '$salt/6g',
                                color: AppColors.salt,
                                pastelColor: AppColors.saltPastel,
                                statusText: salt >= 6
                                    ? '⚠️ Límite diario alcanzado'
                                    : '✅ Consumo adecuado',
                                statusBg: salt >= 6
                                    ? AppColors.saltPastel
                                    : AppColors.successBg,
                                statusTextColor: salt >= 6
                                    ? AppColors.salt
                                    : AppColors.successText,
                                onDecrement: salt > 0
                                    ? () => ref
                                        .read(saltGramsProvider.notifier)
                                        .state--
                                    : null,
                                onIncrement: salt < 6
                                    ? () => ref
                                        .read(saltGramsProvider.notifier)
                                        .state++
                                    : null,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                child: Divider(
                                  height: 1,
                                  thickness: 0.8,
                                  color: AppColors.imcMuted,
                                ),
                              ),
                              DailyIndicatorRow(
                                emoji: '🍬',
                                label: 'Azúcar',
                                valueText: '$sugar/35g',
                                color: AppColors.sugar,
                                pastelColor: AppColors.sugarPastel,
                                statusText: sugar >= 35
                                    ? '⚠️ Límite diario alcanzado'
                                    : '✅ Consumo adecuado',
                                statusBg: sugar >= 35
                                    ? AppColors.sugarPastel
                                    : AppColors.successBg,
                                statusTextColor: sugar >= 35
                                    ? AppColors.sugar
                                    : AppColors.successText,
                                onDecrement: sugar > 0
                                    ? () => ref
                                        .read(sugarGramsProvider.notifier)
                                        .state -= 5
                                    : null,
                                onIncrement: sugar < 35
                                    ? () => ref
                                        .read(sugarGramsProvider.notifier)
                                        .state += 5
                                    : null,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Tarjeta "Tip nutricional" — usa tip de IA o fallback
                        InfoPastelCard(
                          emoji: '🥦',
                          title: 'Tip nutricional',
                          body: plan.dailyTip,
                          backgroundColor: AppColors.tipPastel,
                          titleColor: AppColors.brandMid,
                          bodyColor: const Color(0xFF3E5548),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Navegación inferior ───────────────────────────────────────
          VitaliBottomNav(
            activeIndex: 0,
            onTap: (i) {
              if (i == 1) context.go(AppRoutes.exercise);
              if (i == 2) context.go(AppRoutes.progress);
            },
          ),
        ],
      ),
    );
  }
}

/// Texto de estado IA — discreto, debajo del título de la tarjeta.
class _AiStatusText extends StatelessWidget {
  final String text;
  const _AiStatusText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: AppColors.textHint,
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
