import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';
import 'package:leafolyze/core/widgets/common/rounded_button.dart';

class InputField {
  final String label;
  final String hint;
  final bool isPassword;
  final IconData? suffixIcon;
  final TextEditingController controller;

  const InputField({
    required this.label,
    required this.hint,
    this.isPassword = false,
    this.suffixIcon,
    required this.controller,
  });
}

class AuthForm extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final List<InputField> inputFields;
  final bool showForgotPassword;
  final Function() onPressed;

  const AuthForm({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.inputFields,
    this.showForgotPassword = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: AppFontSize.fontSizeXXL,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spacingXS),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            subtitle,
            style: const TextStyle(
              fontSize: AppFontSize.fontSizeMS,
              fontWeight: AppFontWeight.regular,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.spacingL),
        ...inputFields.map((field) => Column(
              children: [
                TextFormField(
                  controller: field.controller,
                  obscureText: field.isPassword,
                  decoration: InputDecoration(
                    labelText: field.label,
                    hintText: field.hint,
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppBorderRadius.radiusXS),
                    ),
                    suffixIcon: field.suffixIcon != null
                        ? Icon(field.suffixIcon)
                        : null,
                  ),
                ),
                const SizedBox(height: AppSpacing.spacingM),
              ],
            )),
        if (showForgotPassword) ...[
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                // Handle forgot password action
              },
              child: const Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: AppFontSize.fontSizeS,
                  fontWeight: AppFontWeight.semiBold,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.spacingM),
        ] else
          const SizedBox(height: AppSpacing.spacingL),
        RoundedButton(text: buttonText, onPressed: onPressed),
      ],
    );
  }
}
