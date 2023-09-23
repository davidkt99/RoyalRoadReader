import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:royal_reader/api/queries.dart';
import 'package:royal_reader/chaptersList/chapterNameId.dart';
import 'package:royal_reader/weeklyChaptersList/update.dart';
import 'package:royal_reader/weeklyChaptersList/updatesByWeekDay.dart';
import 'package:sizer/sizer.dart';
import '../util/weekDayMap.dart';

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
              var chaptersListByWeekday = <List<Update>>[
                [],
                [],
                [],
                [],
                [],
                [],
                [],
              ];
              for (var update in snapshot.data!){
                chaptersListByWeekday[update.weekDay].add(update);
              }
              chaptersListByWeekday.removeWhere((element) => element.isEmpty);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                          UpdatesByWeekDay(title: "Today", updates: chaptersListByWeekday.last, handleUpdatePressed: handleUpdateChapterPressed),
                        chaptersListByWeekday.length > 1 ? UpdatesByWeekDay(title: "Yesterday", updates: chaptersListByWeekday[chaptersListByWeekday.length-2], handleUpdatePressed: handleUpdateChapterPressed) : Container(),
                    ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: chaptersListByWeekday.length-2,
                      itemBuilder: (context, i) {
                        return UpdatesByWeekDay(title: weekDayMap[i]!, updates: chaptersListByWeekday[i], handleUpdatePressed: handleUpdateChapterPressed);
                      },
                    ),
                  ],
                ),
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
