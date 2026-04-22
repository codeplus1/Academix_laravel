import 'dart:convert';

import 'package:academix/widgets/loading_effect.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api/api.dart';
import '../const/const.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  Future<Map<String, dynamic>> getContact() async {
    final response = await Api().getData('about');
    return json.decode(response.body)['data'];
  }

  Future<void> _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
        backgroundColor: primaryColor,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getContact(),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: loadingEffect(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('No data found.'));
          }

          var mydata = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 450,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    mydata['image'],
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 10),
                DefaultTextStyle(
                  style: const TextStyle(fontSize: 25.0, color: Colors.black),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      WavyAnimatedText('Contact Developer!'),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
                const SizedBox(height: 10),
                _buildContactDetails(mydata),
                const SizedBox(height: 10),
                Text(
                  'Social Media Links',
                  style: TextStyle(fontSize: 28, color: primaryColor),
                ),
                _buildSocialMediaButtons(),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildContactDetails(Map<String, dynamic> mydata) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Name: ',
            style: TextStyle(fontSize: 20, color: primaryColor),
          ),
          TextSpan(
            text: mydata['name'] + '\n',
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          TextSpan(
            text: 'Contact No: ',
            style: TextStyle(fontSize: 20, color: primaryColor),
          ),
          TextSpan(
            text: mydata['phone'] + '\n',
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
          TextSpan(
            text: 'Location: ',
            style: TextStyle(fontSize: 20, color: primaryColor),
          ),
          TextSpan(
            text: mydata['location'] + '\n',
            style: const TextStyle(fontSize: 20, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FacebookButton(
          onPressed: () => _launchURL(facebook),
        ),
        GithubButton(
          onPressed: () => _launchURL(github),
        ),
        IconButton(
          color: primaryColor,
          iconSize: 45,
          icon: const Icon(Icons.wechat_rounded),
          onPressed: () => _launchURL(whatsapp),
        ),
        InstagramButton(
          onPressed: () => _launchURL(instagram),
        ),
        GoogleButton(
          onPressed: () => _launchURL(website),
        ),
      ],
    );
  }
}
