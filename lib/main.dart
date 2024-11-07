import 'package:flutter/material.dart';
import 'package:leafolyze/screens/loginPage.dart';
import 'package:leafolyze/screens/resultScreen.dart';
import 'package:leafolyze/screens/splash.dart';

void main() {
  runApp(const MainApp());
}
class MainApp extends StatelessWidget { 
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResultScreen.new(
        title: 'Bacterial Spot',
        imageUrl: 'https://i.ytimg.com/vi/9UY9Y4iCB08/maxresdefault.jpg',
        description: 'Lorem ipsum dolor sit amet...',
        treatmentTitle: 'Treatment and Prevention',
        treatments: [
          'Fungicides: Lorem ipsum dolor sit amet...',
          'Fungicides: Lorem ipsum dolor sit amet...'
        ],
        pesticideTitle: 'Pesticide',
        pesticides: [
          'Pesticide option 1',
          'Pesticide option 2'
        ],
        status1: 'Berbahaya',
        status2: 'Mudah Menyebar',
        timestamp: '1 m ago',
      ),
    );
  }
}