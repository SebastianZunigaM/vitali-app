import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vitali/core/constants/app_colors.dart';
import 'package:vitali/core/constants/app_constants.dart';
import 'package:vitali/features/auth/data/auth_repository.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/auth_layout.dart';
import 'package:vitali/shared/widgets/feedback_banner.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/segmented_auth_tabs.dart';

/// Pantalla 02 — Registro de usuario.
/// Valida localmente y crea cuenta con Supabase Auth email/password.
class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  String? _validate() {
    if (_nameController.text.trim().isEmpty) {
      return 'Por favor ingresa tu nombre.';
    }
    if (_emailController.text.trim().isEmpty) {
      return 'Por favor ingresa tu correo electrónico.';
    }
    if (_passwordController.text.isEmpty) {
      return 'Por favor ingresa una contraseña.';
    }
    if (_passwordController.text.length < 6) {
      return 'La contraseña debe tener al menos 6 caracteres.';
    }
    if (_passwordController.text != _confirmController.text) {
      return 'Las contraseñas no coinciden.';
    }
    return null;
  }

  String _friendlyError(Object e) {
    final raw = e.toString();
    final msg = raw.toLowerCase();
    debugPrint('[RegisterPage] signUp error: $raw');

    if (msg.contains('user already registered') ||
        msg.contains('user_already_exists') ||
        msg.contains('already been registered') ||
        msg.contains('already registered')) {
      return 'Ya existe una cuenta con este correo.';
    }
    if (msg.contains('invalid email') ||
        msg.contains('invalid_email') ||
        msg.contains('unable to validate email') ||
        msg.contains('email address is invalid')) {
      return 'El correo electrónico no es válido.';
    }
    if (msg.contains('password should be at least') ||
        msg.contains('weak_password') ||
        msg.contains('password is too short') ||
        msg.contains('should be at least 6')) {
      return 'La contraseña es muy débil. Usa al menos 6 caracteres.';
    }
    if (msg.contains('rate limit') ||
        msg.contains('too_many_requests') ||
        msg.contains('for security purposes') ||
        msg.contains('email rate limit')) {
      return 'Demasiados intentos. Espera un momento e inténtalo de nuevo.';
    }
    if (msg.contains('signups not allowed') ||
        msg.contains('signup_disabled') ||
        msg.contains('email logins are disabled')) {
      return 'El registro está temporalmente deshabilitado.';
    }
    if (msg.contains('network') ||
        msg.contains('connection') ||
        msg.contains('socketo') ||
        msg.contains('timeout')) {
      return 'Error de conexión. Verifica tu internet.';
    }
    return 'Ocurrió un error al crear la cuenta. Inténtalo de nuevo.';
  }

  Future<void> _handleSignUp() async {
    final validationError = _validate();
    if (validationError != null) {
      setState(() => _errorMessage = validationError);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Cerrar sesión previa si existe para evitar interferencias con el nuevo registro
    try {
      await ref.read(authRepositoryProvider).signOut();
    } catch (_) {}

    try {
      final email = _emailController.text.trim();
      await ref.read(authRepositoryProvider).signUp(
            email: email,
            password: _passwordController.text,
          );
      if (mounted) context.go(AppRoutes.loginConfirmation, extra: email);
    } catch (e) {
      if (mounted) setState(() => _errorMessage = _friendlyError(e));
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
          // ── Selector segmentado — "Registrarse" activo ────────────────
          SegmentedAuthTabs(
            activeIndex: 1,
            onLoginTap: () => context.go(AppRoutes.login),
            onRegisterTap: () {},
          ),

          // ── Banner de error ───────────────────────────────────────────
          if (_errorMessage != null) ...[
            const SizedBox(height: 16),
            FeedbackBanner(
              message: _errorMessage!,
              type: FeedbackBannerType.error,
            ),
            const SizedBox(height: 14),
          ] else
            const SizedBox(height: 20),

          // ── Campo nombre completo ─────────────────────────────────────
          AppTextField(
            hint: 'Nombre completo',
            icon: Icons.person_outline_rounded,
            controller: _nameController,
            keyboardType: TextInputType.name,
          ),

          const SizedBox(height: 14),

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

          const SizedBox(height: 14),

          // ── Campo confirmar contraseña ────────────────────────────────
          AppTextField(
            hint: 'Confirmar contraseña',
            icon: Icons.lock_outline_rounded,
            isPassword: true,
            obscureText: _obscureConfirmPassword,
            controller: _confirmController,
            onToggleVisibility: () => setState(
                () => _obscureConfirmPassword = !_obscureConfirmPassword),
          ),

          const SizedBox(height: 22),

          // ── Botón Crear cuenta ────────────────────────────────────────
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
                  label: 'Crear cuenta',
                  onPressed: _handleSignUp,
                ),
        ],
      ),
    );
  }
}
