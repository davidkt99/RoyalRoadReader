import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({Key? key, required this.id, required this.name, required this.handleBookPressed, required this.numOfChap}) : super(key: key);

  final int id;
  final String name;
  final Function handleBookPressed;
  final int numOfChap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          handleBookPressed(id, name);
        },
        child: Padding(
          padding: EdgeInsets.all(4.w),
          child: SizedBox(
            height: 8.h,
            width: 90.h,
            child: Text(
              "$name - $numOfChap",
              style: TextStyle(color: Colors.black, fontSize: 2.h),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
