class Note {
  final String document;
  final String title;
  final String created_at;

  // ignore: non_constant_identifier_names
  Note({
    required this.document,
    required this.title,
    // ignore: non_constant_identifier_names
    required this.created_at,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
        document: json['document'],
        title: json['title'],
        created_at: json['created_at']);
  }
}
