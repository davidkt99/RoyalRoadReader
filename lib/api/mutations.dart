import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:royal_reader/api/util.dart';

Future<bool> addBook(String bookUrl) async {

  try{
    var res = await http.post(
        Uri.parse('$url/download/book/'),
      body: jsonEncode(<String, String>{
      'url': bookUrl,
      }
    ),
    );
    debugPrint(res.body.toString());
    var jsonResponse = jsonDecode(res.body);
    if(res.statusCode == 200) {
      return jsonResponse == "true";
    }else{
      throw jsonResponse['message'];
    }
  } catch (e) {
    return Future.error(e.toString());
  }
}