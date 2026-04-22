// ignore_for_file: prefer_const_constructors

import 'package:academix/const/const.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

Widget error500(BuildContext context) {
  return Column(
    children: [
      Center(
        child: SizedBox(
          height: 350,
          child: Lottie.asset(
            'assets/nointernet.json',
          ),
        ),
      ),
      Text(
        'We are fixing the problem.\nPlease wait a moment ...',
        style: TextStyle(fontWeight: FontWeight.w600, color: primaryColor),
      )
    ],
  );
}
