import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:leafolyze/screens/landingPage.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),
        childWidget: SizedBox(
          height: 1000,
          child: Image.asset("lib/assets/images/logo.png"),
        ),
        duration: const Duration(milliseconds: 4500),
        animationDuration: const Duration(milliseconds: 1500),
        onAnimationEnd: () => debugPrint("On Scale End"),
        nextScreen: const Landingpage());
  }
}
