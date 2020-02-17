import 'package:blog/extensions/string_extensions.dart';

void main() {
  var url = "?title=你好";
  var res = url.getRoutingData['title'];
  print(res);
}
