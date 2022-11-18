import 'package:flutter/material.dart';

Widget loadingEffect() {
  return Center(
      child: SizedBox(
    child: Column(
      children: const [
        CircularProgressIndicator(
          backgroundColor: Colors.pink,
        ),
        SizedBox(height: 5),
        Text(
          "Please Wait \nData Loading...",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        )
      ],
    ),
  ));
}
