import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/daily_providers.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/shared/widgets/content_card.dart';
import 'package:vitali/shared/widgets/daily_indicator_row.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/meal_tabs_selector.dart';
import 'package:vitali/shared/widgets/numbered_option_list.dart';
import 'package:vitali/shared/widgets/section_header.dart';
import 'package:vitali/shared/widgets/vitali_app_bar.dart';
import 'package:vitali/shared/widgets/vitali_bottom_nav.dart';

/// Pantalla 08+09+10 — Plan de Alimentación.
/// Estado local mínimo para cambiar visualmente entre Desayuno y Almuerzo.
/// Los indicadores diarios y el tip nutricional son globales del día (no cambian por tab).
class NutritionPage extends ConsumerStatefulWidget {
  const NutritionPage({super.key});

  @override
  ConsumerState<NutritionPage> createState() => _NutritionPageState();
}

class _NutritionPageState extends ConsumerState<NutritionPage> {
  int _activeTab = 0;

  // Opciones estáticas por franja — índice = tab del MealTabsSelector
  static const _mealOptions = [
    // 0 — Desayuno (P08)
    [
      'Batido de proteína con banana y mantequilla de maní',
      'Avena con proteína en polvo y frutas del bosque',
      'Huevos revueltos con espinaca, tomate y pan integral',
    ],
    // 1 — Almuerzo (P10)
    [
      'Arroz integral con pechuga de pollo y vegetales al vapor',
      'Pasta integral con carne magra y salsa de tomate natural',
      'Bowl de quinoa con salmón, aguacate y pepino',
    ],
    // 2 — Cena (P11)
    [
      'Pechuga de pavo con camote y ensalada',
      'Atún con arroz integral y brócoli',
      'Sopa de lentejas con pan de centeno',
    ],
  ];

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(sessionProvider);
    final lifestyleTitle = session.lifestyle?.title ?? 'Deportista';
    final water = ref.watch(waterCountProvider);
    final salt = ref.watch(saltGramsProvider);
    final sugar = ref.watch(sugarGramsProvider);

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
                        // Selector de comidas — cablea el cambio de tab
                        MealTabsSelector(
                          activeIndex: _activeTab,
                          onTabChanged: (i) => setState(() => _activeTab = i),
                        ),

                        const SizedBox(height: 12),

                        // Tarjeta "Opciones para hoy" — cambia con el tab activo
                        ContentCard(
                          title: 'Opciones para hoy',
                          child: NumberedOptionList(
                            options: _mealOptions[_activeTab],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Tarjeta "Indicadores diarios" — global del día, no cambia por tab
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

                        // Tarjeta "Tip nutricional" — global, no cambia por tab
                        const InfoPastelCard(
                          emoji: '🥦',
                          title: 'Tip nutricional',
                          body:
                              'Mastica lentamente y disfruta cada bocado. Comer despacio mejora la digestión y ayuda a reconocer la saciedad.',
                          backgroundColor: AppColors.tipPastel,
                          titleColor: AppColors.brandMid,
                          bodyColor: Color(0xFF3E5548),
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
