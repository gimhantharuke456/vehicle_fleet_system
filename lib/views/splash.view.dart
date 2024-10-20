import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_fleet_system/views/aut.view.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      nextScreen: const AuthView(),
      splash: Image.asset("assets/splash.png"),
    );
  }
}
