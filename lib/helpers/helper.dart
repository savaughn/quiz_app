import 'package:html_unescape/html_unescape.dart';

String stripHtml(String input) {
  return HtmlUnescape().convert(input);
}
