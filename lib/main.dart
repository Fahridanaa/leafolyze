import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:leafolyze/core/home.dart';
import 'package:leafolyze/screens/artikelList_screen.dart';
import 'package:leafolyze/screens/landing_page.dart';
import 'package:leafolyze/screens/productListScreen.dart';
import 'package:leafolyze/screens/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: ArtikelListScreen(),
    );
  }
}
