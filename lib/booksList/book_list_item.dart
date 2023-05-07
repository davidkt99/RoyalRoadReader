import 'package:flutter/material.dart';
import 'package:royal_reader/booksList/book.dart';
import 'package:sizer/sizer.dart';

class BookListItem extends StatelessWidget {
  const BookListItem({Key? key, required this.book, required this.handleBookPressed, required this.handleDeleteDialog}) : super(key: key);

  final Book book;
  final Function handleBookPressed;
  final Function handleDeleteDialog;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          handleBookPressed(book.id, book.name);
        },
        onLongPress: () {
          handleDeleteDialog(book.id);
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
                    book.imageUrl,
                  ),
                ),
                Expanded(
                  flex: 7,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.name,
                              style: TextStyle(fontSize: 1.7.h),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              "by ${book.author}",
                              style: TextStyle(fontSize: 1.5.h),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${book.numOfChap}",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 1.5.h),
                              textAlign: TextAlign.right,
                            ),
                            Text(
                              " Chapters",
                              style: TextStyle(fontSize: 1.5.h),
                              textAlign: TextAlign.right,
                            ),
                          ],
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
