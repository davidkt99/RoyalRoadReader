import 'package:royal_reader/util/parsers.dart';

class Book {
  final int id;
  final String? name;
  final String url;
  final int numOfChap;

  const Book({
    required this.id,
    required this.name,
    required this.url,
    required this.numOfChap
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: parseHtmlString(json['name']),
      url: json['url'],
        numOfChap: json['numOfChap']
    );
  }
}