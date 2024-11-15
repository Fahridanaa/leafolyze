import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/core/widgets/auth/auth_form.dart';
import 'package:leafolyze/core/widgets/auth/driver_text_widget.dart';
import 'package:leafolyze/core/widgets/auth/logo_section_widget.dart';
import 'package:leafolyze/blocs/auth/auth_bloc.dart';
import 'package:leafolyze/blocs/auth/auth_event.dart';
import 'package:leafolyze/blocs/auth/auth_state.dart';
import 'package:leafolyze/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            context.go('/home');
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppSpacing.spacingM),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    LogoSection(),
                    const SizedBox(height: AppSpacing.spacingL),
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Image.asset(
                          'assets/images/group-243.png',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.spacingM),
                    AuthForm(
                      title: 'Welcome Back',
                      subtitle: 'Log in and keep growing.',
                      buttonText: 'Log In',
                      inputFields: [
                        InputField(
                          controller: _emailController,
                          label: 'Email Address',
                          hint: 'm@example.com',
                        ),
                        InputField(
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'Enter password',
                          isPassword: true,
                        ),
                      ],
                      showForgotPassword: true,
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginRequested(
                                email: _emailController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                    ),
                    const SizedBox(height: AppSpacing.spacingXXL),
                    AuthPromptText(
                      promptText: "Don't have an account?",
                      actionText: "Sign up",
                      onTap: () {
                        context.go('/register');
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
