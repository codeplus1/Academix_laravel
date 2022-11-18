import 'package:apnanote/const/const.dart';
import 'package:apnanote/pages/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:splash_view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Apna Note',
      theme: ThemeData(
        primaryColor: primaryColor,
        backgroundColor: primaryColor,
      ),
      home: SplashView(
        backgroundColor: Colors.white,
        showStatusBar: true,
        duration: const Duration(seconds: 1),
        backgroundImageDecoration: const BackgroundImageDecoration(
          image: AssetImage('assets/splash.png'),
          fit: BoxFit.none,
        ),
        done: Done(
          const DashboardScreen(),
        ),
      ),
    );
  }
}
