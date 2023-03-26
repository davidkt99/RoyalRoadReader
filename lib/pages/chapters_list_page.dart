import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../components/book_list_item.dart';
import '../api/queries.dart';
import '../components/chapter_list_item.dart';

class ChaptersPage extends StatefulWidget {
  const ChaptersPage({super.key, required this.id, required this.bookName});

  final int id;
  final String bookName;

  @override
  State<ChaptersPage> createState() => _ChaptersPageState();
}

class _ChaptersPageState extends State<ChaptersPage> {

  void _handleChapterPressed(int id, String name){
    debugPrint('$id pressed');
    context.go(Uri(path: '/chapter/$id', queryParameters: {'name': name}).toString());
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      body: Center(
          child: FutureBuilder(
            future: fetchChapterNamesAndIds(widget.id), // your async method that returns a future
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                var chapterList = List.from(snapshot.data.reversed);
                // if data is loaded
                return ListView.builder(
                  padding: EdgeInsets.all(4.w),
                  itemCount: chapterList.length,
                  reverse: true,
                  itemBuilder: (BuildContext context, int i) {
                    return Center(
                      child: ChapterListItem(id: chapterList[i].id, name: chapterList[i].name, handleChapterPressed: _handleChapterPressed,)
                    );
                  },
                ).build(context);
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
