import 'package:flutter/material.dart';
import 'package:vitali/shared/widgets/app_text_field.dart';
import 'package:vitali/shared/widgets/auth_layout.dart';
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
    return AuthLayout(
      cardContent: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SegmentedAuthTabs(
            activeIndex: 0,
            onLoginTap: () {},
            onRegisterTap: () {},
          ),

          const SizedBox(height: 20),

          AppTextField(
            hint: 'Correo electrónico',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),

          const SizedBox(height: 14),

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
