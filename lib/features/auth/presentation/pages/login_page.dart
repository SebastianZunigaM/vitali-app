import 'package:flutter/material.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/auth_layout.dart';
import 'package:vitali/shared/widgets/feedback_banner.dart';
import 'package:vitali/shared/widgets/link_text.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/segmented_auth_tabs.dart';

/// Pantalla 01 — Inicio de Sesión.
/// También representa la Pantalla 03 cuando [showSuccessBanner] es true
/// y [prefilledEmail] contiene el correo recién registrado.
class LoginPage extends StatefulWidget {
  final bool showSuccessBanner;
  final String? prefilledEmail;

  const LoginPage({
    super.key,
    this.showSuccessBanner = false,
    this.prefilledEmail,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.prefilledEmail ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Selector de pestañas (Login activo) ──────────────────────
          SegmentedAuthTabs(
            activeIndex: 0,
            onLoginTap: () {},
            onRegisterTap: () {},
          ),

          // ── Banner de confirmación (solo Pantalla 03) ─────────────────
          if (widget.showSuccessBanner) ...[
            const SizedBox(height: 16),
            const FeedbackBanner(
              message:
                  '¡Cuenta creada exitosamente! Ahora puedes iniciar sesión.',
              type: FeedbackBannerType.success,
            ),
            const SizedBox(height: 14),
          ] else
            const SizedBox(height: 20),

          // ── Campo correo electrónico ──────────────────────────────────
          AppTextField(
            hint: 'Correo electrónico',
            icon: Icons.email_outlined,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 14),

          // ── Campo contraseña ──────────────────────────────────────────
          AppTextField(
            hint: 'Contraseña',
            icon: Icons.lock_outline_rounded,
            isPassword: true,
            obscureText: _obscurePassword,
            onToggleVisibility: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),

          const SizedBox(height: 22),

          PrimaryGradientButton(
            label: 'Ingresar',
            onPressed: () {},
          ),

          const SizedBox(height: 16),

          Center(
            child: LinkText(
              text: '¿No tienes cuenta? ',
              linkText: 'Regístrate aquí',
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
