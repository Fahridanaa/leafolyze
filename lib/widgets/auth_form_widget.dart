import 'package:flutter/material.dart';
import 'package:leafolyze/constants/color.dart';
import 'package:leafolyze/widgets/rounded_button.dart';

class InputField {
  final String label;
  final String hint;
  final bool isPassword;
  final IconData? suffixIcon;

  const InputField({
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.suffixIcon,
  });
}

class AuthFormWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final List<InputField> inputFields;
  final bool showForgotPassword;

  const AuthFormWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.inputFields,
    this.showForgotPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 6),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            subtitle,
            style: const TextStyle(
                fontSize: 14, color: AppColors.mutedForegroundColor),
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 24),
        ...inputFields.map((field) => Column(
              children: [
                TextField(
                  obscureText: field.isPassword,
                  decoration: InputDecoration(
                    labelText: field.label,
                    hintText: field.hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: field.suffixIcon != null
                        ? Icon(field.suffixIcon)
                        : null,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            )),
        if (showForgotPassword) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Handle forgot password action
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ] else
          const SizedBox(height: 32),
        RoundedButton(text: buttonText, onPressed: () {}),
      ],
    );
  }
}
