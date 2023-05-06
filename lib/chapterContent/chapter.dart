import 'package:royal_reader/util/parsers.dart';

class Chapter {
  final int id;
  final String? name;
  final String? content;
  final String? dateAdded;

  const Chapter({
    required this.id,
    required this.name,
    required this.content,
    required this.dateAdded,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: parseHtmlString(json['name']),
      content: json['content'],
      dateAdded: json['dateAdded'] ?? "",
    );
  }
}