import 'package:flutter/material.dart';
import 'package:leafolyze/widgets/auth/auth_form.dart';
import 'package:leafolyze/widgets/auth/driver_text_widget.dart';
import 'package:leafolyze/widgets/auth/logo_section_widget.dart';

final List<InputField> loginInputFields = [
  const InputField(
    label: 'Email Address',
    hint: 'm@example.com',
  ),
  const InputField(
    label: 'Password',
    hint: 'Enter password',
    isPassword: true,
    suffixIcon: Icons.visibility,
  ),
];

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                LogoSection(),
                const SizedBox(height: 22),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Image.asset(
                      'assets/images/group-243.png',
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                AuthForm(
                  title: 'Welcome Back',
                  subtitle: 'Sign in to continue',
                  buttonText: 'Log In',
                  inputFields: loginInputFields,
                  showForgotPassword: true,
                ),
                const SizedBox(height: 48),
                AuthPromptText(
                  promptText: "Don't have an account?",
                  actionText: "Sign up",
                  onTap: () {
                    // Navigate to register screen
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
