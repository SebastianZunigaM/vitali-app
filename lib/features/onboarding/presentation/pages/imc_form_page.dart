import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/content_card.dart';
import 'package:vitali/shared/widgets/green_header.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/two_column_field_row.dart';

/// Pantalla 04 — Calculadora de IMC: Formulario de Datos.
/// Recolecta nombre, edad, peso y altura para calcular el IMC.
class ImcFormPage extends StatelessWidget {
  const ImcFormPage({super.key});

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
              child: ContentCard(
                title: 'Tus datos',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Nombre
                    AppTextField(
                      label: 'Nombre',
                      hint: 'Tu nombre completo',
                      icon: Icons.person_outline_rounded,
                      keyboardType: TextInputType.name,
                    ),

                    const SizedBox(height: 14),

                    // Edad y Peso — fila de dos columnas
                    TwoColumnFieldRow(
                      left: AppTextField(
                        label: 'Edad',
                        hint: 'años',
                        icon: Icons.calendar_today_outlined,
                        keyboardType: TextInputType.number,
                      ),
                      right: AppTextField(
                        label: 'Peso',
                        hint: 'kg',
                        icon: Icons.monitor_weight_outlined,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Altura
                    AppTextField(
                      label: 'Altura',
                      hint: 'ej: 1.70',
                      icon: Icons.height_rounded,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Botón Calcular IMC
                    PrimaryGradientButton(
                      label: 'Calcular IMC',
                      onPressed: () => context.push(AppRoutes.imcResult),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
