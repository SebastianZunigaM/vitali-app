import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/shared/widgets/app_outline_button.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/content_card.dart';
import 'package:vitali/shared/widgets/green_header.dart';
import 'package:vitali/shared/widgets/imc_result_card.dart';
import 'package:vitali/shared/widgets/imc_scale_bar.dart';
import 'package:vitali/shared/widgets/info_pastel_card.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/two_column_field_row.dart';

/// Pantalla 05 — Calculadora de IMC: Resultado.
/// Muestra datos del formulario pre-rellenados y la tarjeta de resultado IMC.
class ImcResultPage extends StatelessWidget {
  const ImcResultPage({super.key});

  static const double _imcValue = 24.9;

  @override
  Widget build(BuildContext context) {
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
                      '👋 ¡Hola, usuario!',
                      style: TextStyle(
                        color: AppColors.textOnGreen,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Calculemos tu Índice de Masa Corporal',
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
                  // Datos completados del formulario
                  ContentCard(
                    title: 'Tus datos',
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        AppTextField(
                          label: 'Nombre',
                          hint: 'Tu nombre completo',
                          icon: Icons.person_outline_rounded,
                          keyboardType: TextInputType.name,
                          initialValue: 'Usuario Demo',
                        ),

                        const SizedBox(height: 14),

                        TwoColumnFieldRow(
                          left: AppTextField(
                            label: 'Edad',
                            hint: 'años',
                            icon: Icons.calendar_today_outlined,
                            keyboardType: TextInputType.number,
                            initialValue: '19',
                          ),
                          right: AppTextField(
                            label: 'Peso',
                            hint: 'kg',
                            icon: Icons.monitor_weight_outlined,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            initialValue: '90',
                          ),
                        ),

                        const SizedBox(height: 14),

                        AppTextField(
                          label: 'Altura',
                          hint: 'ej: 1.70',
                          icon: Icons.height_rounded,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          initialValue: '1.90',
                        ),

                        const SizedBox(height: 24),

                        PrimaryGradientButton(
                          label: 'Calcular IMC',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Tarjeta resultado IMC
                  ContentCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Valor IMC + badge clasificación
                        const ImcResultCard(
                          imcValue: _imcValue,
                          classification: ImcClassification.healthy,
                        ),

                        const SizedBox(height: 20),

                        // Escala visual
                        const ImcScaleBar(imcValue: _imcValue),

                        const SizedBox(height: 20),

                        // Meta recomendada
                        const InfoPastelCard(
                          emoji: '🎯',
                          title: 'Meta recomendada',
                          body: 'Mantener el peso',
                          backgroundColor: AppColors.successBg,
                          titleColor: AppColors.brandMid,
                          bodyColor: AppColors.brandMid,
                          boldBody: true,
                        ),

                        const SizedBox(height: 10),

                        // Recomendación del día
                        const InfoPastelCard(
                          emoji: '💡',
                          title: 'Recomendación del día',
                          body:
                              'Incluye frutas y verduras de colores en cada comida',
                          backgroundColor: AppColors.tipPastel,
                        ),

                        const SizedBox(height: 24),

                        // Botón Continuar
                        PrimaryGradientButton(
                          label: 'Continuar',
                          hasArrow: true,
                          gradientColors: AppColors.gradientButtonContinue,
                          onPressed: () => context.push(AppRoutes.lifestyle),
                        ),

                        const SizedBox(height: 12),

                        // Botón Recalcular
                        AppOutlineButton(
                          label: 'Recalcular',
                          icon: Icons.refresh_rounded,
                          onPressed: () => context.pop(),
                        ),
                      ],
                    ),
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
