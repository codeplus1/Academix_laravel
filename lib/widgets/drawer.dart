import 'dart:io';

import 'package:academix/pages/notes_download1.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/const.dart';
import '../pages/about_us.dart';

void _launchURL(String url) async {
  // ignore: deprecated_member_use
  if (!await launch(url)) throw 'Could not launch $url';
}

Widget myDrawer(BuildContext context) {
  return Drawer(
    child: ListView(
      children: [
        SizedBox(
          height: 130,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1.0), // Set the corner radius
            child: Image.network(
              'https://i.ibb.co/YRz8KmT/Academix-1.png',
              fit: BoxFit
                  .cover, // Optional: ensures the image fills the container
            ),
          ),
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
                MaterialPageRoute(builder: (context) => NotesDownload()));
          },
          leading: Icon(
            Icons.download,
            color: primaryColor,
          ),
          title: const Text("Download Notes"),
        ),
        // ListTile(
        //   onTap: () {},
        //   leading: Icon(
        //     Icons.favorite_border_rounded,
        //     color: primaryColor,
        //   ),
        //   title: const Text("Favourite"),
        // ),
        const Divider(),
        ListTile(
          onTap: () {
            _launchURL(facebook);
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
            _launchURL(website);
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
            _launchURL(feedbackForm);
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
            _launchURL(feedbackForm);
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
            _launchURL(updateappLink);
            // print('Saroj');
          },
          leading: Icon(
            Icons.verified_sharp,
            color: primaryColor,
          ),
          title: const Text("Updated Version"),
          subtitle: const Text("1.0.7"),
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
