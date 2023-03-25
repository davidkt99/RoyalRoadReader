import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:royal_reader/types/book.dart';

const url = "http://192.168.1.238:8080";

Future<List<Book>> fetchBooks() async {
  List<Book> books = [];
  var res = await http.get(Uri.parse('$url/books'));
  for (var jsonBook in jsonDecode(res.body)){
    books.add(Book.fromJson(jsonBook));
  }

  return books;
}