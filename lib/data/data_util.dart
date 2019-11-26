import 'dart:convert';

import '../model/post_info.dart';
import 'package:http/http.dart' as http;

///
///获取分类文章列表
/// catalog 分类
Future<List<PostInfo>> fetchPostListInfo(String catalog) async {
  List<PostInfo> _posts = [];

  var url = "content/data/post_data.json";
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  JsonDecoder jsonDecoder = JsonDecoder();
  Map respMap = jsonDecoder.convert(decoder.convert(response.bodyBytes));

  List jsonList = respMap['data'];

  List<PostInfo> postInfoList =
      jsonList.map((e) => PostInfo.fromJson(e)).toList();
  // 解析数据

  if (postInfoList.length > 0) {
    if (catalog != "all") {
      postInfoList.forEach((post) {
        if (post.catalog == catalog) {
          _posts.add(post);
          print(post.title);
        }
      });
    } else {
      _posts = postInfoList;
    }
  }
  return _posts;
}

Future<String> fetchPostContent(String postPath) async {
  var url = "/content" + postPath;
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  String respContent = decoder.convert(response.bodyBytes);
  return respContent;
}

Future<Map> fetchBookList() async {
  var url = "content/data/booklist_data.json";
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  JsonDecoder jsonDecoder = JsonDecoder();
  Map respMap = jsonDecoder.convert(decoder.convert(response.bodyBytes));
  print(respMap['data'][0]['title']);
  return respMap;
}
