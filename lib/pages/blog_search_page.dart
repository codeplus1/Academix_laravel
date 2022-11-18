import 'dart:convert';

import 'package:apnanote/const/const.dart';
import 'package:flutter/material.dart';

import '../Api/api.dart';
import '../models/blog.dart';
import '../widgets/blog_box.dart';
import '../widgets/loading_effect.dart';

Future<List<Blog>> getBlogs(String? text) async {
  var response = await Api().getData('blog');
  var data = json.decode(response.body)['data'];
  final dat = (data as List).map((e) => Blog.fromJson(e)).toList();
  final searchData = dat
      .where((element) => element.title.toLowerCase().contains(text!.trim()))
      .toList();
  return searchData;
}

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchText;
  final searchController = TextEditingController();

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
                child: FutureBuilder<List<Blog>>(
                  future: getBlogs(searchText),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: loadingEffect(),
                      );
                    }
                    if ((snapshot.data as List).isEmpty) {
                      return const Center(
                        child: Text('Try keyword like computer, Hardware'),
                      );
                    }
                    if (snapshot.hasData) {
                      return snapshot.data == null
                          ? Center(
                              child: loadingEffect(),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: snapshot.data.length,
                              itemBuilder: (BuildContext context, int index) {
                                Blog mydata = snapshot.data[index];
                                return blogBox(
                                    context,
                                    mydata.title,
                                    mydata.description,
                                    mydata.image,
                                    mydata.created_at);
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
