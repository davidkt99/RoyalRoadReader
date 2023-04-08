import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:royal_reader/types/book.dart';
import 'package:royal_reader/types/chapter.dart';

import '../types/chapterNameId.dart';

const url = "http://localhost:8080";
const timeout = Duration(seconds: 2);

Future<List<Book>> fetchBooks() async {
  List<Book> books = [];
  try{
    var res = await http.get(Uri.parse('$url/books')).timeout(timeout);
    var jsonResponse = jsonDecode(res.body);
    if(jsonResponse["status"] == 200) {
      for (var jsonBook in jsonResponse["data"]){
        books.add(Book.fromJson(jsonBook));
      }
      debugPrint(jsonResponse);
    }else{
      throw jsonResponse['message'];
    }
  } catch (e) {
    return Future.error(e.toString());
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