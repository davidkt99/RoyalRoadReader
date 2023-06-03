import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/api/queries.dart';
import 'package:royal_reader/chaptersList/chapterNameId.dart';
import 'package:royal_reader/weeklyChaptersList/update.dart';
import 'package:royal_reader/weeklyChaptersList/updateListItem.dart';
import 'package:sizer/sizer.dart';

class UpdatesListPage extends StatefulWidget {
  const UpdatesListPage({Key? key}) : super(key: key);

  @override
  State<UpdatesListPage> createState() => _UpdatesListPageState();
}

class _UpdatesListPageState extends State<UpdatesListPage> {
  late Future<List<Update>> updates;

  @override
  void initState() {
    super.initState();
    updates = fetchUpdates();
  }

  Future<void> refreshUpdates() async {
    setState(() {
      updates = fetchUpdates();
    });
  }

  void handleUpdateChapterPressed(int chapterId, String chapterName){
    context.pushNamed("update", params: {"loc":0.toString()}, extra: [ChapterNameId(id: chapterId, name: chapterName, dateAdded: "")]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Updates'),
      ),
      body: RefreshIndicator(
        onRefresh: () => refreshUpdates(),
        child: FutureBuilder(
          future: updates,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data?.isEmpty ?? true) {
                return Stack(
                    children: [
                      const Center(
                        child: Text(
                          'No Updates Found',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: const [],
                      )
                    ]
                );
              }

              return ListView.builder(
                padding: EdgeInsets.all(4.w),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  return UpdateListItem(update: snapshot.data![i], handleUpdatePressed: handleUpdateChapterPressed);
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}', style: const TextStyle(color: Colors.red)));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
