import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/widgets/auth/auth_form.dart';
import 'package:leafolyze/core/widgets/auth/driver_text_widget.dart';
import 'package:leafolyze/core/widgets/auth/logo_section_widget.dart';
import 'package:leafolyze/utils/constants.dart';

final List<InputField> registerInputFields = [
  InputField(
    label: 'Full Name',
    hint: 'John Doe',
    controller: TextEditingController(),
  ),
  InputField(
    label: 'Email Address',
    hint: 'm@example.com',
    controller: TextEditingController(),
  ),
  InputField(
    label: 'Password',
    hint: 'Enter password',
    isPassword: true,
    suffixIcon: Icons.visibility,
    controller: TextEditingController(),
  ),
];

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 68),
                LogoSection(),
                const SizedBox(height: 189.5),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    AuthForm(
                      title: 'Join Us',
                      subtitle: 'Grow with us',
                      buttonText: 'Register',
                      inputFields: registerInputFields,
                      onPressed: () {
                        context.go('/home');
                      },
                    ),
                    Positioned(
                      right: 0,
                      top: -181.5,
                      child: Image.asset(
                        'assets/images/undraw_enter_uhqk 1.png',
                        width: 224,
                        height: 248,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.spacingXXL),
                AuthPromptText(
                  promptText: "Already have an account?",
                  actionText: "Sign in",
                  onTap: () {
                    context.go('/login');
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
