import 'package:flutter/material.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/brand_header.dart';
import 'package:vitali/shared/widgets/gradient_background.dart';
import 'package:vitali/shared/widgets/link_text.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/segmented_auth_tabs.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const SizedBox(height: 48),

                // ── Identidad de marca ──────────────────────────────────
                const BrandHeader(),

                const SizedBox(height: 32),

                // ── Tarjeta de autenticación ────────────────────────────
                _AuthCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Selector segmentado
                      SegmentedAuthTabs(
                        activeIndex: 0,
                        onLoginTap: () {},
                        onRegisterTap: () {},
                      ),

                      const SizedBox(height: 20),

                      // Campo correo electrónico
                      AppTextField(
                        hint: 'Correo electrónico',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 14),

                      // Campo contraseña
                      AppTextField(
                        hint: 'Contraseña',
                        icon: Icons.lock_outline_rounded,
                        isPassword: true,
                        obscureText: _obscurePassword,
                        onToggleVisibility: () {
                          setState(() => _obscurePassword = !_obscurePassword);
                        },
                      ),

                      const SizedBox(height: 22),

                      // Botón primario
                      PrimaryGradientButton(
                        label: 'Ingresar',
                        onPressed: () {},
                      ),

                      const SizedBox(height: 16),

                      // Enlace de registro
                      Center(
                        child: LinkText(
                          text: '¿No tienes cuenta? ',
                          linkText: 'Regístrate aquí',
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 28),

                // ── Texto motivacional inferior ─────────────────────────
                const Text(
                  'Mejora tu calidad de vida, un hábito a la vez 🌱',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSlogan,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Auth Card ────────────────────────────────────────────────────────────────

class _AuthCard extends StatelessWidget {
  final Widget child;

  const _AuthCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 24,
            spreadRadius: 0,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }
}
