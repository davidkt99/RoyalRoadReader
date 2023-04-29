
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

import '../api/queries.dart';
import '../util/style.dart';
import 'chapter.dart';

class ChapterContentPage extends StatefulWidget {
  const ChapterContentPage({super.key, required this.id, required this.chapters});

  final int id;
  final List chapters;

  @override
  State<ChapterContentPage> createState() => _ChapterContentPageState();
}

class _ChapterContentPageState extends State<ChapterContentPage> {
  late Future<Chapter> chapter;

  @override
  void initState() {
    super.initState();
    chapter = fetchChapter(widget.chapters[widget.id].id);
  }

  bool previousButtonIsEnabled(int id, List chapters){
    return id >= chapters.length-1;
  }
  bool nextButtonIsEnabled(int id, List chapters){
    return id <= 0;
  }


  Future<void> refreshContent(int id, List chapters) async {
    setState(() {
      chapter = fetchChapter(chapters[id].id);
    });
  }

  void handlePreviousChapter(int id, List chapters){
    context.pushReplacementNamed("chapter", params: {"id":(id+1).toString()}, extra: chapters);
  }

  void handleNextChapter(int id, List chapters){
    context.pushReplacementNamed("chapter", params: {"id":(id-1).toString()}, extra: chapters);
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.chapters[widget.id].name;


    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
          child: RefreshIndicator(
            onRefresh: () => refreshContent(widget.id, widget.chapters),
            child: FutureBuilder(
              future: chapter, // your async method that returns a future
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  // if data is loaded
                  debugPrint(snapshot.data.content);
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 4.w,
                      left: 4.w,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Html(
                              data: snapshot.data.content,
                            style: {
                              "table": Style(
                                backgroundColor: Colors.blue[100],
                              ),
                              "tr": Style(
                                border: const Border(bottom: BorderSide(color: Colors.grey)),
                              ),
                              "th": Style(
                                padding: const EdgeInsets.all(6),
                                backgroundColor: Colors.grey,
                              ),
                              "td": Style(
                                padding: const EdgeInsets.all(6),
                                alignment: Alignment.topLeft,
                              ),
                              'h5': Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
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
                          SizedBox(
                            height: 4.h,
                          )
                        ],
                      ),
                    ),
                  );
                }  else if (snapshot.hasError) {
                  return Stack(
                      children: [
                        Center(
                          child: Text(
                            snapshot.error.toString(),
                            style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [],
                        )
                      ]
                  );
                }else {
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
