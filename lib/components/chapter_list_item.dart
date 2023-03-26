import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ChapterListItem extends StatelessWidget {
  const ChapterListItem({Key? key, required this.id, required this.name, required this.handleChapterPressed}) : super(key: key);

  final int id;
  final String name;
  final Function handleChapterPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          handleChapterPressed;
        },
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: SizedBox(
            height: 8.h,
            width: 90.h,
            child: Text(
              name + " - " + id.toString(),
              style: TextStyle(color: Colors.black, fontSize: 2.h),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
