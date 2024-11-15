import 'package:flutter/material.dart';
import 'package:leafolyze/utils/constants.dart';

class DividerWithText extends StatelessWidget {
  final String text;
  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.spacingS),
          child: Text(
            text,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}

class AuthPromptText extends StatelessWidget {
  final String promptText;
  final String actionText;
  final VoidCallback onTap;

  const AuthPromptText({
    super.key,
    required this.promptText,
    required this.actionText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          promptText,
          style: TextStyle(
            color: AppColors.textMutedColor,
            fontSize: AppFontSize.fontSizeMS,
          ),
        ),
        const SizedBox(width: AppSpacing.spacingXXS),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              color: Colors.black,
              fontSize: AppFontSize.fontSizeMS,
              fontWeight: AppFontWeight.semiBold,
            ),
          ),
        ),
      ],
    );
  }
}
