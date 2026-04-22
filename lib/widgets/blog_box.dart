import 'package:flutter/material.dart';

import '../const/const.dart';
import '../pages/blog_details_page.dart';

class BlogBox extends StatefulWidget {
  final String title;
  final String description;
  final String image;
  final String createdAt;
  final String? searchText;

  const BlogBox({
    super.key,
    required this.title,
    required this.description,
    required this.image,
    required this.createdAt,
    this.searchText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _BlogBoxState createState() => _BlogBoxState();
}

class _BlogBoxState extends State<BlogBox> {
  bool isFavorite = false; // To track favorite status

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      // Here you can implement saving to a database or local storage
      if (isFavorite) {
        // Save to favorites logic
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.title} added to favorites!'),
        ));
      } else {
        // Remove from favorites logic
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${widget.title} removed from favorites!'),
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogPage(
              title: widget.title,
              description: widget.description,
              image: widget.image,
            ),
          ),
        );
      },
      child: Card(
        color: cardcolor,
        child: ListTile(
          leading: SizedBox(
            height: 55,
            width: 55,
            child: Image.network(
              widget.image,
              fit: BoxFit.fitHeight,
            ),
          ),
          title: _highlightSearchText(widget.title, widget.searchText),
          subtitle: Text('Updated ${widget.createdAt}'),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: _toggleFavorite, // Toggle favorite status
          ),
        ),
      ),
    );
  }

  // Function to highlight the search text in the title
  Widget _highlightSearchText(String text, String? searchText) {
    if (searchText == null || searchText.isEmpty) {
      return Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      );
    }

    final searchWords = searchText.toLowerCase();
    final startIndex = text.toLowerCase().indexOf(searchWords);
    if (startIndex == -1) {
      return Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
      );
    }

    final endIndex = startIndex + searchWords.length;

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text.substring(0, startIndex),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
          ),
          TextSpan(
            text: text.substring(startIndex, endIndex),
            style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          TextSpan(
            text: text.substring(endIndex),
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
