import '../util/parsers.dart';

class ChapterNameId {
  final int id;
  final String? name;

  const ChapterNameId({
    required this.id,
    required this.name,
  });

  factory ChapterNameId.fromJson(Map<String, dynamic> json) {
    return ChapterNameId(
      id: json['id'],
      name: parseHtmlString(json['name']),
    );
  }
}