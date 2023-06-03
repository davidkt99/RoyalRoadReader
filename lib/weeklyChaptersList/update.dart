import 'package:royal_reader/util/weekDayMap.dart';

class Update {
  final int bookId;
  final int chapterId;
  final String bookName;
  final String chapterName;
  final int weekDay;
  final String imageUrl;

  const Update({
    required this.bookId,
    required this.chapterId,
    required this.bookName,
    required this.chapterName,
    required this.weekDay,
    required this.imageUrl,
  });

  factory Update.fromJson(Map<String, dynamic> json) {
    return Update(
      bookId: json['bookId'],
      chapterId: json['chapterId'],
      bookName: json['bookName'],
      chapterName: json['chapterName'],
      weekDay:json['weekDay'],
      imageUrl: json['imageUrl'],
    );
  }
}