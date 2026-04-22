import 'dart:convert';
import 'package:academix/Api/api.dart';
import 'package:academix/models/Notes.dart';
import 'package:academix/widgets/server_error.dart';
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
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    color: primaryColor,
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Search Downloads',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: searchController,
                cursorColor: primaryColor,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: 'Enter keywords...',
                  hintStyle: TextStyle(color: Colors.black54),
                  prefixIcon: Icon(Icons.search, color: primaryColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onFieldSubmitted: (val) {
                  if (val.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please provide search text.'),
                    ));
                  } else {
                    setState(() {
                      searchText = val;
                    });
                  }
                },
              ),
              if (searchText != null && searchText!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Searching for: "$searchText"',
                    style: TextStyle(color: Colors.green, fontSize: 16),
                  ),
                ),
              const SizedBox(height: 20),
              if (searchText != null)
                Expanded(
                  child: FutureBuilder<List<Note>>(
                    future: getNotes(searchText),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: loadingEffect());
                      }
                      if (snapshot.hasError) {
                        return error500(context);
                      }
                      if ((snapshot.data ?? []).isEmpty) {
                        return const Center(
                          child: Text(
                              'No results found. Try keywords like "HTML", "CSS".'),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Note mydata = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Card(
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
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
