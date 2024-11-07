import 'package:flutter/material.dart';
import 'package:leafolyze/core/home.dart';
import 'package:leafolyze/screens/register_screen.dart';
import 'package:leafolyze/screens/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
