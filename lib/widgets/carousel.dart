import 'dart:convert';
import 'package:flutter/material.dart';
import '../Api/api.dart';
import 'loading_effect.dart';

Widget carousel(BuildContext context) {
  Future<List<dynamic>> getSlide() async {
    var response = await Api().getData('slide');
    var decodedData = json.decode(response.body);
    return decodedData['data']; // Fetch slides
  }

  return FutureBuilder<List<dynamic>>(
    future: getSlide(),
    builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: loadingEffect());
      } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
        return SizedBox(
          height: 130.0,
          width: MediaQuery.of(context).size.width - 10,
          child: PageView.builder(
            // reverse: true,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    snapshot.data![index]['image'], // Fetching images
                    fit: BoxFit.cover,
                    width: double.infinity),
              );
            },
          ),
        );
      } else {
        return const Center(child: Text("No slides available."));
      }
    },
  );
}
