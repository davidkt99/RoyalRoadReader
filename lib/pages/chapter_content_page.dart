import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/types/book.dart';
import 'package:royal_reader/types/chapter.dart';
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

    Future<Future<Chapter>> _refreshContent(BuildContext context, int id) async {
      return fetchChapter(id);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: RefreshIndicator(
            onRefresh: () => _refreshContent(context, widget.id),
            child: FutureBuilder(
              future: fetchChapter(widget.id), // your async method that returns a future
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  // if data is loaded
                  return Padding(
                    padding: EdgeInsets.all(4.w),
                    child: SingleChildScrollView(
                      child: StyledText(
                        text: snapshot.data.content,
                        tags: {
                          'strong': StyledTextTag(style: const TextStyle(fontWeight: FontWeight.bold)),
                          'em': StyledTextTag(style: const TextStyle(fontStyle: FontStyle.italic))
                        },
                      ),
                    ),
                  );
                } else {
                  // if data not loaded yet
                  return const CircularProgressIndicator();
                }
              },
            ),
          )
      ),
    );
  }
}
