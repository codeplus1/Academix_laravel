import 'package:academix/const/const.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget loadingEffect() {
  return Column(
    // mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SizedBox(
        width: 150,
        child: Lottie.asset(
          'assets/loading.json',
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Loading',
            style: TextStyle(
                fontSize: 18, color: primaryColor, fontWeight: FontWeight.w500),
          ),
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                '...',
                textStyle: TextStyle(
                    color: ancentColor,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
                speed: Duration(
                  milliseconds: 350,
                ),
              ),
            ],
            repeatForever: true,
            isRepeatingAnimation: true,
          ),
        ],
      ),
    ],
  );
}
