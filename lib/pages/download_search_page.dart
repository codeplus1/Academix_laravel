import 'dart:convert';

import 'package:apnanote/Api/api.dart';
import 'package:apnanote/models/Notes.dart';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../const/const.dart';
import '../widgets/loading_effect.dart';

Future<List<Note>> getNotes(String? text) async {
  var response = await Api().getData('download');
  var data = json.decode(response.body)['data'];
  final dat = (data as List).map((e) => Note.fromJson(e)).toList();
  final searchData = dat
      .where((element) => element.title.toLowerCase().contains(
            text!.trim(),
          ))
      .toList();
  return searchData;
}

class DownloadSearchPage extends StatefulWidget {
  const DownloadSearchPage({super.key});

  @override
  State<DownloadSearchPage> createState() => _DownloadSearchPageState();
}

class _DownloadSearchPageState extends State<DownloadSearchPage> {
  String? searchText;
  final searchController = TextEditingController();

  void _launchURL(String url) async {
    // ignore: deprecated_member_use
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: Column(
          children: [
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 0.0),
              color: primaryColor,
              child: TextFormField(
                controller: searchController,
                cursorColor: Colors.white,
                cursorHeight: 25,
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(
                    Icons.screen_search_desktop_outlined,
                    size: 30,
                  ),
                  // label: Text(""),
                ),
                onFieldSubmitted: (val) {
                  if (val.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('please provide searchText'),
                    ));
                  } else {
                    setState(() {
                      searchText = val;
                      searchController.clear();
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            if (searchText != null)
              Expanded(
                child: FutureBuilder<List<Note>>(
                  future: getNotes(searchText),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: loadingEffect(),
                      );
                    }
                    if ((snapshot.data as List).isEmpty) {
                      return const Center(
                        child:
                            Text('Try keyword like C,c++,java in lowercase '),
                      );
                    }
                    if (snapshot.hasData) {
                      return snapshot.data == null
                          ? Center(
                              child: loadingEffect(),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Note mydata = snapshot.data[index];
                                return SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Card(
                                        child: ListTile(
                                          onTap: () {
                                            _launchURL(mydata.document);
                                          },
                                          title: Text(mydata.title),
                                          subtitle: Text(mydata.created_at),
                                          trailing: Icon(
                                            Icons.download_for_offline_sharp,
                                            size: 30,
                                            color: primaryColor,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                    } else if (snapshot.hasError) {
                      return const Text('Check Your Wifi Connection');
                    } else {
                      return Center(
                        child: loadingEffect(),
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
