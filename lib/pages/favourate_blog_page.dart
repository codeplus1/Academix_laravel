import 'package:flutter/material.dart';

class FavoriteBlogsPage extends StatelessWidget {
  final List<Widget> favoriteBlogs; // List to hold favorite blogs

  const FavoriteBlogsPage({super.key, required this.favoriteBlogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Blogs'),
      ),
      body: favoriteBlogs.isEmpty
          ? const Center(
              child: Text('No favorite blogs yet!'),
            )
          : ListView(
              children: favoriteBlogs, // Display favorite blogs
            ),
    );
  }
}
