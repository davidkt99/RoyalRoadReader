
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/types/chapter.dart';
import 'package:sizer/sizer.dart';
import 'package:styled_text/styled_text.dart';

import '../api/queries.dart';
import '../util/style.dart';

class ChapterContentPage extends StatefulWidget {
  const ChapterContentPage({super.key, required this.id, required this.chapters});

  final int id;
  final List chapters;

  @override
  State<ChapterContentPage> createState() => _ChapterContentPageState();
}

class _ChapterContentPageState extends State<ChapterContentPage> {
  @override
  Widget build(BuildContext context) {
    String name = widget.chapters[widget.id].name;

    bool previousButtonIsEnabled(int id, List chapters){
      return id >= chapters.length-1;
    }
    bool nextButtonIsEnabled(int id, List chapters){
      return id <= 0;
    }


    Future<Future<Chapter>> refreshContent(BuildContext context, int id, List chapters) async {
      return fetchChapter(chapters[id].id);
    }

    void handlePreviousChapter(int id, List chapters){
      context.pushReplacementNamed("chapter", params: {"id":(id+1).toString()}, extra: chapters);
    }

    void handleNextChapter(int id, List chapters){
      context.pushReplacementNamed("chapter", params: {"id":(id-1).toString()}, extra: chapters);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
          child: RefreshIndicator(
            onRefresh: () => refreshContent(context, widget.id, widget.chapters),
            child: FutureBuilder(
              future: fetchChapter(widget.chapters[widget.id].id), // your async method that returns a future
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  // if data is loaded
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 4.w,
                      left: 4.w,
                      bottom: 4.h
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StyledText(
                            text: snapshot.data.content,
                            tags: {
                              'strong': StyledTextTag(style: const TextStyle(fontWeight: FontWeight.bold)),
                              'em': StyledTextTag(style: const TextStyle(fontStyle: FontStyle.italic))
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                  onPressed: previousButtonIsEnabled(widget.id, widget.chapters)
                                      ? null :
                                      () {
                                    handlePreviousChapter(widget.id, widget.chapters);
                                  },
                                  style: chapterNavButtonStyle,
                                  child: const Text("Previous"),
                              ),
                              ElevatedButton(
                                  onPressed: nextButtonIsEnabled(widget.id, widget.chapters)
                                      ? null :
                                      () {
                                        handleNextChapter(widget.id, widget.chapters);
                                  },
                                  style: chapterNavButtonStyle,
                                  child: const Text("Next")
                              )
                            ],
                          ),
                        ],
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
