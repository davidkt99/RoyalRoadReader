
//here goes the function
import 'package:html/parser.dart';
import 'package:styled_text/styled_text.dart';

String? parseHtmlString(String htmlString) {

  final document = parse(htmlString);
  final String? parsedString = parse(document.body?.text).documentElement?.text;

  return parsedString;
}