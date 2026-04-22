import 'dart:convert';
import 'package:academix/const/const.dart';
import 'package:academix/widgets/server_error.dart';
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
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? searchText;
  final searchController = TextEditingController();

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
                    'Search Blogs',
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
                onChanged: (val) {
                  setState(() {
                    searchText = val; // Update search text as user types
                  });
                },
                onFieldSubmitted: (val) {
                  if (val.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please provide search text.'),
                    ));
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
                  child: FutureBuilder<List<Blog>>(
                    future: getBlogs(searchText),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Blog>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: loadingEffect());
                      }
                      if (snapshot.hasError) {
                        return error500(context);
                      }
                      if ((snapshot.data ?? []).isEmpty) {
                        return const Center(
                          child: Text(
                              'No results found. Try keywords like "computer", "hardware".'),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          Blog mydata = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: BlogBox(
                              title: mydata.title,
                              description: mydata.description,
                              image: mydata.image,
                              createdAt: mydata.created_at,
                              searchText:
                                  searchText, // Pass the search text for highlighting
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
