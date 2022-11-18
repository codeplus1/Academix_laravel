import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_awesome_buttons/flutter_awesome_buttons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Api/api.dart';
import '../const/const.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  Future getContact() async {
    var response = await Api().getData('about');
    var data = json.decode(response.body)['data'];
    return data;
  }

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getContact(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.data == null
              ? const Center(
                  child: SizedBox(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.pink,
                    ),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var mydata = snapshot.data[index];
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
                          const SizedBox(
                            height: 10,
                          ),
                          DefaultTextStyle(
                            style: const TextStyle(
                                fontSize: 25.0, color: Colors.black),
                            child: AnimatedTextKit(
                              animatedTexts: [
                                WavyAnimatedText('Contact Developer !'),
                              ],
                              isRepeatingAnimation: true,
                              onTap: () {
                                // ignore: avoid_print
                                print('');
                              },
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '\nName: ',
                                  style: TextStyle(
                                      fontSize: 20, color: primaryColor),
                                ),
                                TextSpan(
                                  text: mydata['name'] + '\n',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Contact No: ',
                                  style: TextStyle(
                                      fontSize: 20, color: primaryColor),
                                ),
                                TextSpan(
                                  text: mydata['phone'] + '\n',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Location: ',
                                  style: TextStyle(
                                      fontSize: 20, color: primaryColor),
                                ),
                                TextSpan(
                                  text: mydata['location'] + '\n',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Social Media Links.',
                            style: TextStyle(fontSize: 28, color: primaryColor),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FacebookButton(
                                onPressed: () {
                                  _launchURL(
                                      'https://www.facebook.com/sjcoders.np/');
                                },
                              ),
                              IconButton(
                                color: primaryColor,
                                iconSize: 48,
                                icon: const Icon(Icons.telegram),
                                onPressed: () {
                                  _launchURL('https://t.me/enfo404');
                                },
                              ),
                              GithubButton(
                                onPressed: () {
                                  _launchURL(
                                      'https://github.com/sarojyadav88505');
                                },
                              ),
                              IconButton(
                                color: primaryColor,
                                iconSize: 45,
                                icon: const Icon(Icons.whatsapp),
                                onPressed: () {
                                  _launchURL('https://wa.me/+977 9814896965');
                                },
                              ),
                              InstagramButton(
                                onPressed: () {
                                  _launchURL(
                                      'https://www.instagram.com/saroj.jnp/');
                                },
                              ),
                              GoogleButton(
                                onPressed: () {
                                  _launchURL(
                                      'https://sjcomputercenter.com.np/');
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
