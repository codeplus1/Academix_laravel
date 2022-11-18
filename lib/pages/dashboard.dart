// ignore_for_file: library_private_types_in_public_api

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:apnanote/pages/blog_search_page.dart';

import 'package:flutter/material.dart';

import '../const/const.dart';
import '../widgets/blogs.dart';
import '../widgets/carousel.dart';
import '../widgets/drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future onrefresh() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(
        () {
          blogs(context);
          carousel(context);
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime? lastPressed;
    return Scaffold(
      appBar: AppBar(
        elevation: .5,
        backgroundColor: primaryColor,
        title: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            ColorizeAnimatedText(
              'Apna Notes',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
              onPressed: () {
                onrefresh();
              },
              icon: const Icon(
                Icons.wifi_protected_setup_outlined,
                size: 30,
              ),
            ),
          )
        ],
      ),
      drawer: myDrawer(context),
      body: RefreshIndicator(
        onRefresh: onrefresh,
        child: WillPopScope(
          onWillPop: () async {
            final now = DateTime.now();
            // ignore: prefer_const_declarations
            final maxDuration = const Duration(seconds: 2);
            final isWarning = lastPressed == null ||
                now.difference(lastPressed!) > maxDuration;
            if (isWarning) {
              lastPressed = DateTime.now();

              final snackBar = SnackBar(
                content: const Text('Double Tap To Close App'),
                duration: maxDuration,
              );

              ScaffoldMessenger.of(context)
                ..removeCurrentSnackBar()
                ..showSnackBar(snackBar);
              return false;
            } else {
              return true;
            }
          },
          // Code end Here of DOuble tap
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Slider Component
                carousel(context),
                blogs(context),
                // Course Type Components
              ],
            ),
          ),
        ),
      ),
    );
  }
}
