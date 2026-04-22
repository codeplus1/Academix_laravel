// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, duplicate_ignore

import 'package:academix/widgets/carousel.dart';
import 'package:academix/widgets/loading_effect.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:academix/pages/blog_search_page.dart';
import 'package:academix/widgets/tools.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/const.dart';
import '../widgets/blogs.dart';
// import '../widgets/carousel.dart';
import '../widgets/drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isLoading = false; // Track loading state

  Future onrefresh() async {
    setState(() {
      _isLoading = true; // Start loading
    });

    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        blogs(context);
        carousel(context);
        _isLoading = false; // Stop loading after data is loaded
      });
    });
  }

  void _launchURL(String url) async {
    if (!await launch(url)) throw 'Could not launch $url';
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
              'Academix',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
        ),
        actions: [
          // Refresh button (no loading indicator here)
          IconButton(
            onPressed: () {
              onrefresh();
            },
            icon: Icon(
              Icons.refresh_rounded,
              color: textColor,
            ),
          ),

          // Search button
          IconButton(
            color: textColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchPage()),
              );
            },
            icon: Icon(
              Icons.search,
              size: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: InkWell(
              onTap: () {
                _launchURL("https://www.academix.codeplus.com.np/");
              },
              child: Icon(
                Icons.menu_book_sharp,
                color: textColor,
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
            final maxDuration = const Duration(seconds: 2);
            final isWarning = lastPressed == null ||
                now.difference(lastPressed!) > maxDuration;
            if (isWarning) {
              lastPressed = DateTime.now();

              final snackBar = SnackBar(
                backgroundColor: primaryColor,
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
          child: _isLoading
              ? Center(
                  child: loadingEffect(), // Show loading indicator
                )
              : SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.normal),
                  child: Column(
                    children: [
                      // herowidget(context),
                      // Slider Component
                      SizedBox(height: 5),
                      carousel(context),
                      SizedBox(height: 5),
                      const Tools(),
                      blogs(context),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
