import 'package:royal_reader/util/parsers.dart';

class Chapter {
  final int id;
  final String? name;
  final String? content;

  const Chapter({
    required this.id,
    required this.name,
    required this.content,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'],
      name: parseHtmlString(json['name']),
      content: parseHtmlString(json['content']),
    );
  }
}