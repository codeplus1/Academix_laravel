import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/const.dart';
import '../pages/about_us.dart';
import '../pages/notes_download.dart';

void _launchURL(String url) async {
  // ignore: deprecated_member_use
  if (!await launch(url)) throw 'Could not launch $url';
}

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        SizedBox(
          height: 120,
          child:
              Image.network('http://www.sjcomputercenter.com.np/image/1.png'),
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: Icon(
            Icons.space_dashboard_rounded,
            color: primaryColor,
          ),
          title: const Text("Dashboard"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NotesDownload()));
          },
          leading: Icon(
            Icons.download,
            color: primaryColor,
          ),
          title: const Text("Download Notes"),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            _launchURL("https://www.facebook.com/vipcoding/");
            // print('Saroj');
          },
          leading: Icon(
            Icons.facebook_sharp,
            color: primaryColor,
          ),
          title: const Text("Facebook Page"),
        ),
        ListTile(
          onTap: () {
            _launchURL("https://www.sjcomputercenter.com.np/");
            // print('Saroj');
          },
          leading: Icon(
            Icons.wordpress,
            color: primaryColor,
          ),
          title: const Text("Visit Website"),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            _launchURL(
                "https://play.google.com/store/apps/details?id=np.com.sjcomputercenter.digitalshikshaa");
            // print('Saroj');
          },
          leading: Icon(
            Icons.feed_outlined,
            color: primaryColor,
          ),
          title: const Text("Feedback"),
        ),
        ListTile(
          onTap: () {
            _launchURL(
                "https://play.google.com/store/apps/details?id=np.com.sjcomputercenter.digitalshikshaa");
            // print('Saroj');
          },
          leading: Icon(
            Icons.star,
            color: primaryColor,
          ),
          title: const Text("Rate us"),
        ),
        const Divider(),
        ListTile(
          title: const Text("About us"),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AboutUsPage()));
          },
          leading: Icon(
            Icons.info_outline,
            color: primaryColor,
          ),
        ),
        const Divider(),
        ListTile(
          onTap: () {
            _launchURL(
                "https://play.google.com/store/apps/details?id=np.com.sjcomputercenter.digitalshikshaa");
            // print('Saroj');
          },
          leading: Icon(
            Icons.verified_sharp,
            color: primaryColor,
          ),
          title: const Text("Updated Version"),
          subtitle: const Text("1.0.2"),
        ),
        const Divider(),
        ListTile(
          title: const Text("Exit"),
          onTap: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            }
          },
          leading: Icon(
            Icons.logout,
            color: primaryColor,
          ),
        ),
      ],
    ),
  );
}
