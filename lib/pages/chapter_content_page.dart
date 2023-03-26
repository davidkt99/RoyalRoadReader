import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/types/book.dart';
import 'package:sizer/sizer.dart';
import 'package:styled_text/styled_text.dart';

import '../components/book_list_item.dart';
import '../api/queries.dart';

class ChapterContentPage extends StatefulWidget {
  const ChapterContentPage({super.key, required this.title, required this.id});

  final String title;
  final int id;

  @override
  State<ChapterContentPage> createState() => _ChapterContentPageState();
}

class _ChapterContentPageState extends State<ChapterContentPage> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: FutureBuilder(
            future: fetchChapter(widget.id), // your async method that returns a future
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                // if data is loaded
                return Padding(
                  padding: EdgeInsets.all(4.w),
                  child: SingleChildScrollView(
                    child: Container(
                      child:
                      StyledText(
                        text: snapshot.data.content,
                        tags: {
                          'strong': StyledTextTag(style: TextStyle(fontWeight: FontWeight.bold)),
                          'em': StyledTextTag(style: TextStyle(fontStyle: FontStyle.italic))
                        },
                      ),
                      // Text(snapshot.data.content),
                      // Html(data: snapshot.data.content),
                    ),
                  ),
                );
              } else {
                // if data not loaded yet
                return const CircularProgressIndicator();
              }
            },
          )
      ),
    );
  }
}
