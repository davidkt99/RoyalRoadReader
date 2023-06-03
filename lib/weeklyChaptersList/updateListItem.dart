import 'package:flutter/material.dart';
import 'package:royal_reader/util/weekDayMap.dart';
import 'package:royal_reader/weeklyChaptersList/update.dart';
import 'package:sizer/sizer.dart';

class UpdateListItem extends StatelessWidget {
  const UpdateListItem({Key? key, required this.update, required this.handleUpdatePressed}) : super(key: key);

  final Update update;
  final Function handleUpdatePressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          handleUpdatePressed(update.chapterId, update.chapterName);
        },
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: SizedBox(
              height: 8.h,
              width: 90.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Image.network(
                      update.imageUrl,
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            update.bookName,
                            style: TextStyle(fontSize: 1.5.h),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            update.chapterName,
                            style: TextStyle(fontSize: 1.7.h, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            weekDayMap[update.weekDay],
                            style: TextStyle(fontSize: 1.5.h),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
}
