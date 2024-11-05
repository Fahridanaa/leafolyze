import 'package:flutter/material.dart';
import 'package:leafolyze/screens/loginPage.dart';
import 'package:leafolyze/screens/splash.dart';

void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget { 
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}