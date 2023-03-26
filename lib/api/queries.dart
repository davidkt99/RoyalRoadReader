import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:royal_reader/types/book.dart';
import 'package:royal_reader/types/chapter.dart';

import '../types/chapterNameId.dart';

const url = "http://192.168.1.238:8080";

Future<List<Book>> fetchBooks() async {
  List<Book> books = [];
  var res = await http.get(Uri.parse('$url/books'));
  for (var jsonBook in jsonDecode(res.body)){
    books.add(Book.fromJson(jsonBook));
  }

  return books;
}

/// Chapters will have null contents
Future<List<ChapterNameId>> fetchChapterNamesAndIds(int id) async {
  List<ChapterNameId> chapters = [];
  var res = await http.get(Uri.parse('$url/chapter/all/nameId/$id'));
  for (var jsonChapter in jsonDecode(res.body)){
    chapters.add(ChapterNameId.fromJson(jsonChapter));
  }

  return chapters;
}