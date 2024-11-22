import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:leafolyze/blocs/auth/auth_bloc.dart';
import 'package:leafolyze/blocs/auth/auth_event.dart';
import 'package:leafolyze/blocs/auth/auth_state.dart';
import 'package:leafolyze/core/widgets/auth/auth_form.dart';
import 'package:leafolyze/core/widgets/auth/driver_text_widget.dart';
import 'package:leafolyze/core/widgets/auth/logo_section_widget.dart';
import 'package:leafolyze/core/widgets/notification/custom_dialog.dart';
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
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            CustomDialog.showPopupDialog(
              context: context,
              title: 'Loading',
              message: 'Please wait while we register your account...',
              icon: Icons.hourglass_top,
              iconColor: Colors.blue,
            );
          } else if (state is Authenticated) {
            CustomDialog.showPopupDialog(
              context: context,
              title: 'Success',
              message: 'Registration successful!',
              icon: Icons.check_circle,
              iconColor: Colors.green,
              onClose: () {
                context.go('/home'); // Navigate to home on success
              },
            );
          } else if (state is AuthError) {
            CustomDialog.showPopupDialog(
              context: context,
              title: 'Error',
              message: state.message,
              icon: Icons.error,
              iconColor: Colors.red,
            );
          }
        },
        child: SafeArea(
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
                          final name = registerInputFields[0].controller.text;
                          final email = registerInputFields[1].controller.text;
                          final password = registerInputFields[2].controller.text;

                          if (name.isEmpty || email.isEmpty || password.isEmpty) {
                            CustomDialog.showPopupDialog(
                              context: context,
                              title: 'Validation Error',
                              message: 'All fields are required.',
                              icon: Icons.warning,
                              iconColor: Colors.orange,
                            );
                            return;
                          }

                          // Dispatch RegisterRequested event
                          context.read<AuthBloc>().add(
                                RegisterRequested(
                                  name: name,
                                  email: email,
                                  password: password,
                                  birth: '2000-01-01', // Replace with actual birth data
                                  gender: 'Other', // Replace with actual gender data
                                  address: 'Unknown', // Replace with actual address
                                  access: 'User', // Replace with actual access level
                                ),
                              );
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
      ),
    );
  }
}
