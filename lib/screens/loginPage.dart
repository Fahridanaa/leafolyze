import 'package:flutter/material.dart';
import 'package:leafolyze/widgets/driverText.dart';
import 'package:leafolyze/widgets/loginButton.dart';
import 'package:leafolyze/widgets/loginForm.dart';
import 'package:leafolyze/widgets/logoSection.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView( // Menambahkan SingleChildScrollView untuk mencegah overflow
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60), // Tambahkan jarak untuk posisi logo saat keyboard muncul
                LogoSection(),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hello, Welcome Back!',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 8),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Log in and keep growing.',
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(height: 32),
                LoginForm(),
                const SizedBox(height: 24),
                LoginButton(text: 'Log In'),
                const SizedBox(height: 16),
                const DividerWithText(text: 'OR CONTINUE WITH'),
                const SizedBox(height: 16),
                GoogleSignInButton(),
                const SizedBox(height: 24),
                SignUpPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
