import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/types/chapterNameId.dart';
import 'package:sizer/sizer.dart';

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
  late Future<List<ChapterNameId>> chapters;

  @override
  void initState() {
    super.initState();
    chapters = fetchChapterNamesAndIds(widget.id);
  }

  void handleChapterPressed(int id, String name, List chapters){
    debugPrint('$id pressed');
    context.pushNamed("chapter", params: {"id":id.toString()}, extra: chapters);
  }

  Future<void> refreshChapters(int id) async {
    setState(() {
      chapters = fetchChapterNamesAndIds(id);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.bookName),
      ),
      body: Center(
          child: RefreshIndicator(
            onRefresh: () => refreshChapters(widget.id),
            child: FutureBuilder(
              future: chapters, // your async method that returns a future
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List chapterList = List.from(snapshot.data.reversed);
                  // if data is loaded
                  return ListView.builder(
                    padding: EdgeInsets.all(4.w),
                    itemCount: chapterList.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Center(
                        child: ChapterListItem(id: i, name: chapterList[i].name, handleChapterPressed: handleChapterPressed, chapters: chapterList,)
                      );
                    },
                  ).build(context);
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
