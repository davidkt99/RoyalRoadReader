import 'package:royal_reader/util/parsers.dart';

class Book {
  final int id;
  final String? name;
  final String author;
  final String imageUrl;
  final int numOfChap;

  const Book({
    required this.id,
    required this.name,
    required this.author,
    required this.imageUrl,
    required this.numOfChap
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      name: parseHtmlString(json['name']),
        author: json['author'],
        imageUrl: json['imageUrl'],
        numOfChap: json['numOfChap'],
    );
  }
}