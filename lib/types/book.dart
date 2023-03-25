import 'package:royal_reader/util/parsers.dart';

class Book {
  final int id;
  final String? name;
  final String url;

  const Book({
    required this.id,
    required this.name,
    required this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: parseHtmlString(json['name']),
      url: json['url'],
    );
  }
}