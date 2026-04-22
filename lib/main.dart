import 'package:academix/const/const.dart';
import 'package:academix/pages/dashboard.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:splash_view/splash_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Academix',
      theme: ThemeData(
        primaryColor: primaryColor,
        iconTheme: const IconThemeData(
          color: Colors
              .white, // Set the icon (including back button) color globally
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor, // AppBar background color
          iconTheme: const IconThemeData(
            color: Colors
                .white, // Set back button (navigation icon) color to white
          ),
        ),
      ),
      home: SplashView(
        // backgroundColor: primaryColor,
        showStatusBar: true,
        duration: const Duration(seconds: 5),
        done: Done(
          DashboardScreen(),
        ),
        title: Center(
          child: Column(
            children: [
              Lottie.asset(
                'assets/splash.json', // Replace with your Lottie file
                fit: BoxFit.contain,
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TyperAnimatedText(
                    'नमस्ते म सरोज यादव🙏\n Welcome to Academix',
                    textStyle: TextStyle(
                        color: ancentColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    speed: Duration(
                      milliseconds: 100,
                    ),
                  ),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              ),
              // Text("नमस्ते म सरोज यादव🙏\n Welcome to Academix ")
            ],
          ),
        ),
      ),
    );
  }
}
