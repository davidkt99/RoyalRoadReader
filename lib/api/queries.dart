import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:royal_reader/types/book.dart';
import 'package:royal_reader/types/chapter.dart';

import '../types/chapterNameId.dart';

const url = "http://192.168.1.238:8080";
const timeout = Duration(seconds: 2);

Future<List<Book>> fetchBooks() async {
  List<Book> books = [];
  try{
    var res = await http.get(Uri.parse('$url/books')).timeout(timeout);
    for (var jsonBook in jsonDecode(res.body)){
      books.add(Book.fromJson(jsonBook));
    }
  } on TimeoutException catch (_) {
    // A timeout occurred.
  } on SocketException catch (_) {
    // Other exception
  }


  return books;
}

Future<List<ChapterNameId>> fetchChapterNamesAndIds(int id) async {
  List<ChapterNameId> chapters = [];
  var res = await http.get(Uri.parse('$url/chapter/all/nameId/$id')).timeout(timeout);
  for (var jsonChapter in jsonDecode(res.body)){
    chapters.add(ChapterNameId.fromJson(jsonChapter));
  }

  return chapters;
}

Future<Chapter> fetchChapter(int id) async {
  var res = await http.get(Uri.parse('$url/chapter/$id')).timeout(timeout);
  var jsonChapter = jsonDecode(res.body);

  return Chapter.fromJson(jsonChapter);
}