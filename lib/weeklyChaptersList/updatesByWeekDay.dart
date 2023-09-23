import 'package:flutter/material.dart';
import 'package:royal_reader/weeklyChaptersList/update.dart';
import 'package:royal_reader/weeklyChaptersList/updateListItem.dart';
import 'package:sizer/sizer.dart';

class UpdatesByWeekDay extends StatelessWidget {
  const UpdatesByWeekDay({super.key, required this.title, required this.updates, required this.handleUpdatePressed});

  final String title;
  final List<Update> updates;
  final void Function(int chapterId, String chapterName) handleUpdatePressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 1.h, top: 1.h),
            child: Text(title, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold)),
          ),
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: updates.length,
            itemBuilder: (context, i) {
              return UpdateListItem(update: updates[i], handleUpdatePressed: handleUpdatePressed);
            },
          ),
        ]),
    );
  }
}
