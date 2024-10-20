import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_fleet_system/constatns.dart';
import 'package:vehicle_fleet_system/views/splash.view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashView(),
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
            color: primaryColor,
            titleTextStyle: TextStyle(color: Colors.white),
            iconTheme: IconThemeData(
              color: Colors.white,
            )),
      ),
    );
  }
}
