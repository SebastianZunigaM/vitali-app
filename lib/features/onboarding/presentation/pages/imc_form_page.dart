import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/onboarding/domain/models/imc_result_data.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/content_card.dart';
import 'package:vitali/shared/widgets/feedback_banner.dart';
import 'package:vitali/shared/widgets/green_header.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/two_column_field_row.dart';

/// Pantalla 04 — Calculadora de IMC: Formulario de Datos.
/// Recolecta nombre, edad, peso y altura. Calcula el IMC y navega a P05.
class ImcFormPage extends ConsumerStatefulWidget {
  const ImcFormPage({super.key});

  @override
  ConsumerState<ImcFormPage> createState() => _ImcFormPageState();
}

class _ImcFormPageState extends ConsumerState<ImcFormPage> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  void _onCalculate() {
    final name = _nameController.text.trim();
    final age = int.tryParse(_ageController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());
    final height = double.tryParse(_heightController.text.trim());

    if (name.isEmpty ||
        age == null || age <= 0 ||
        weight == null || weight <= 0 ||
        height == null || height <= 0) {
      setState(() {
        _errorMessage =
            'Por favor completa todos los campos con valores válidos.';
      });
      return;
    }

    setState(() => _errorMessage = null);

    final result = ImcResultData.calculate(
      name: name,
      age: age,
      weight: weight,
      height: height,
    );

    ref.read(sessionProvider.notifier).state =
        ref.read(sessionProvider).copyWith(imcResult: result);

    context.push(AppRoutes.imcResult, extra: result);
  }

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
                    // Banner de error — visible solo tras validación fallida
                    if (_errorMessage != null) ...[
                      FeedbackBanner(
                        message: _errorMessage!,
                        type: FeedbackBannerType.error,
                      ),
                      const SizedBox(height: 14),
                    ],

                    // Nombre
                    AppTextField(
                      label: 'Nombre',
                      hint: 'Tu nombre completo',
                      icon: Icons.person_outline_rounded,
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                    ),

                    const SizedBox(height: 14),

                    // Edad y Peso — fila de dos columnas
                    TwoColumnFieldRow(
                      left: AppTextField(
                        label: 'Edad',
                        hint: 'años',
                        icon: Icons.calendar_today_outlined,
                        controller: _ageController,
                        keyboardType: TextInputType.number,
                      ),
                      right: AppTextField(
                        label: 'Peso',
                        hint: 'kg',
                        icon: Icons.monitor_weight_outlined,
                        controller: _weightController,
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
                      controller: _heightController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Botón Calcular IMC
                    PrimaryGradientButton(
                      label: 'Calcular IMC',
                      onPressed: _onCalculate,
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
