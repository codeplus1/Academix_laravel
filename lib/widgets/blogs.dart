import 'dart:convert';

import 'package:flutter/material.dart';

import '../Api/api.dart';
import 'blog_box.dart';
import 'loading_effect.dart';

Future getBlogs() async {
  var response = await Api().getData('blog');
  var data = json.decode(response.body)['data'];
  return data;
}

Widget blogs(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      children: [
        FutureBuilder(
          future: getBlogs(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
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
                        var mydata = snapshot.data[index];
                        return blogBox(
                            context,
                            mydata['title'],
                            mydata['description'],
                            mydata['image'].toString(),
                            mydata['created_at']);
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
      ],
    ),
  );
}
