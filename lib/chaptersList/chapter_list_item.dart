import 'package:flutter/material.dart';
import 'package:royal_reader/chaptersList/chapterNameId.dart';
import 'package:sizer/sizer.dart';

class ChapterListItem extends StatelessWidget {
  const ChapterListItem({Key? key, required this.loc, required this.chapter, required this.handleChapterPressed, required this.chapters}) : super(key: key);

  final int loc;
  final ChapterNameId chapter;
  final Function handleChapterPressed;
  final List chapters;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          handleChapterPressed(loc, chapter.name, chapters);
        },
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: SizedBox(
            height: 8.h,
            width: 90.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  chapter.name,
                  style: TextStyle(fontSize: 2.h),
                  textAlign: TextAlign.center,
                ),
                Text(
                    chapter.dateAdded,
                    style: TextStyle(fontSize: 1.5.h),
                    textAlign: TextAlign.center
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
