import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:royal_reader/api/util.dart';
import 'package:royal_reader/booksList/book.dart';
import 'package:royal_reader/chapterContent/chapter.dart';

import '../chaptersList/chapterNameId.dart';
import '../weeklyChaptersList/update.dart';



Future<List<Book>> fetchBooks() async {
  List<Book> books = [];
  try{
    var res = await http.get(Uri.parse('$url/books')).timeout(queryTimeout);
    var jsonResponse = jsonDecode(res.body);
    if(res.statusCode == 200) {
      for (var jsonBook in jsonResponse){
        books.add(Book.fromJson(jsonBook));
      }
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
  try{
    var res = await http.get(Uri.parse('$url/chapter/all/nameId/$id')).timeout(queryTimeout);
    var jsonResponse = jsonDecode(res.body);

    if(res.statusCode == 200){
      for (var jsonChapter in jsonResponse){
        chapters.add(ChapterNameId.fromJson(jsonChapter));
      }
    }else{
      throw jsonResponse['message'];
    }
  }catch(e){
    return Future.error(e.toString());
  }

  return chapters;
}

Future<Chapter> fetchChapter(int id) async {
  Chapter chapter;
  try{
    var res = await http.get(Uri.parse('$url/chapter/$id')).timeout(queryTimeout);
    var jsonResponse = jsonDecode(res.body);

    if(res.statusCode == 200){
      chapter = Chapter.fromJson(jsonResponse);
    }else{
      throw jsonResponse['message'];
    }
  }catch(e){
    return Future.error(e.toString());
  }
  return chapter;
}

Future<List<Update>> fetchUpdates() async {
  List<Update> updates = [];
  try {
    var res = await http.get(Uri.parse('$url/updates')).timeout(
        queryTimeout);
    var jsonResponse = jsonDecode(res.body);

    if (res.statusCode == 200) {
      for (var jsonUpdate in jsonResponse){
        updates.add(Update.fromJson(jsonUpdate));
      }
    } else {
      throw jsonResponse['message'];
    }
  } catch (e) {
    return Future.error(e.toString());
  }

  return updates;
}