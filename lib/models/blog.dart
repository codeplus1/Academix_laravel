class Blog {
  final String title;
  final String description;
  final String image;
  // ignore: non_constant_identifier_names
  final String created_at;

  // ignore: non_constant_identifier_names
  Blog(
      {required this.title,
      required this.image,
      required this.description,
      // ignore: non_constant_identifier_names
      required this.created_at});

  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
        title: json['title'],
        image: json['image'],
        description: json['description'],
        created_at: json['created_at']);
  }
}
