import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/app/providers/session_provider.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/auth/data/auth_repository.dart';
import 'package:vitali/features/profile/data/profile_repository.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/auth_layout.dart';
import 'package:vitali/shared/widgets/feedback_banner.dart';
import 'package:vitali/shared/widgets/link_text.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/segmented_auth_tabs.dart';

/// Pantalla 01 — Inicio de Sesión.
/// También representa Pantalla 03 cuando [showSuccessBanner] es true.
class LoginPage extends ConsumerStatefulWidget {
  final bool showSuccessBanner;
  final String? prefilledEmail;

  const LoginPage({
    super.key,
    this.showSuccessBanner = false,
    this.prefilledEmail,
  });

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _obscurePassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.prefilledEmail ?? '');
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _friendlyError(Object e) {
    final msg = e.toString().toLowerCase();
    if (msg.contains('invalid login credentials') ||
        msg.contains('invalid_credentials') ||
        msg.contains('invalid email or password')) {
      return 'Correo o contraseña incorrectos.';
    }
    if (msg.contains('email not confirmed') ||
        msg.contains('email_not_confirmed')) {
      return 'Revisa tu correo para confirmar la cuenta antes de iniciar sesión.';
    }
    if (msg.contains('network') || msg.contains('socketo') ||
        msg.contains('connection')) {
      return 'Error de conexión. Verifica tu internet.';
    }
    return 'Ocurrió un error. Inténtalo de nuevo.';
  }

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() =>
          _errorMessage = 'Por favor ingresa tu correo y contraseña.');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Paso 1 — Autenticación con Supabase
    try {
      await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = _friendlyError(e);
          _isLoading = false;
        });
      }
      return;
    }

    // Paso 2 — Cargar perfil existente y decidir destino
    try {
      final profile =
          await ref.read(profileRepositoryProvider).getCurrentProfile();

      if (!mounted) return;

      if (profile != null) {
        // Restaurar sesión local con datos del perfil guardado
        ref.read(sessionProvider.notifier).state = AppSessionData(
          imcResult: profile.toImcResultData(),
          lifestyle: profile.toLifestyleOption(),
        );
        context.go(AppRoutes.nutrition);
      } else {
        // Sin perfil → completar onboarding
        context.go(AppRoutes.imcForm);
      }
    } catch (_) {
      if (mounted) {
        setState(() =>
            _errorMessage =
                'No se pudo cargar tu perfil. Inténtalo de nuevo.');
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
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
            onRegisterTap: () => context.go(AppRoutes.register),
          ),

          // ── Banner de confirmación (Pantalla 03) o error ──────────────
          if (widget.showSuccessBanner) ...[
            const SizedBox(height: 16),
            const FeedbackBanner(
              message:
                  '¡Cuenta creada exitosamente! Ahora puedes iniciar sesión.',
              type: FeedbackBannerType.success,
            ),
            const SizedBox(height: 14),
          ] else if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            FeedbackBanner(
              message: _errorMessage!,
              type: FeedbackBannerType.error,
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
            controller: _passwordController,
            onToggleVisibility: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),

          const SizedBox(height: 22),

          // ── Botón Ingresar ────────────────────────────────────────────
          _isLoading
              ? const SizedBox(
                  height: 52,
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
                  label: 'Ingresar',
                  onPressed: _handleSignIn,
                ),

          const SizedBox(height: 16),

          Center(
            child: LinkText(
              text: '¿No tienes cuenta? ',
              linkText: 'Regístrate aquí',
              onTap: () => context.go(AppRoutes.register),
            ),
          ),
        ],
      ),
    );
  }
}
