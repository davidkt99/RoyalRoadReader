import '../util/parsers.dart';

class ChapterNameId {
  final int id;
  final String name;
  final String dateAdded;

  const ChapterNameId({
    required this.id,
    required this.name,
    required this.dateAdded,
  });

  factory ChapterNameId.fromJson(Map<String, dynamic> json) {
    return ChapterNameId(
      id: json['id'],
      name: parseHtmlString(json['name']) ?? "null",
      dateAdded: json['dateAdded'] ?? "null",
    );
  }
}