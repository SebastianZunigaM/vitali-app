import 'package:flutter/material.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/auth_layout.dart';
import 'package:vitali/shared/widgets/primary_gradient_button.dart';
import 'package:vitali/shared/widgets/segmented_auth_tabs.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    return AuthLayout(
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Selector segmentado — "Registrarse" activo (índice 1)
          SegmentedAuthTabs(
            activeIndex: 1,
            onLoginTap: () {},
            onRegisterTap: () {},
          ),

          const SizedBox(height: 20),

          // Campo nombre completo
          AppTextField(
            hint: 'Nombre completo',
            icon: Icons.person_outline_rounded,
          ),

          const SizedBox(height: 14),

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
            onToggleVisibility: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),

          const SizedBox(height: 14),

          // Campo confirmar contraseña
          AppTextField(
            hint: 'Confirmar contraseña',
            icon: Icons.lock_outline_rounded,
            isPassword: true,
            obscureText: _obscureConfirmPassword,
            onToggleVisibility: () =>
                setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
          ),

          const SizedBox(height: 22),

          // Botón primario — sin LinkText debajo (a diferencia del Login)
          PrimaryGradientButton(
            label: 'Crear cuenta',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
