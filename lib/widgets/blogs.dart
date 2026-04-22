import 'dart:convert';
import 'package:academix/widgets/server_error.dart';
import 'package:flutter/material.dart';
import '../Api/api.dart';
import 'blog_box.dart'; // Make sure this imports the new BlogBox StatefulWidget
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
                        return BlogBox(
                          // Use BlogBox StatefulWidget
                          title: mydata['title'],
                          description: mydata['description'],
                          image: mydata['image'].toString(),
                          createdAt: mydata['created_at'],
                          searchText: null, // Pass searchText if needed
                        );
                      },
                    );
            } else if (snapshot.hasError) {
              return error500(context);
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
