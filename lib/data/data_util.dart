import 'dart:convert';

import 'package:blog/model/gallery_info.dart';
import 'package:blog/model/project_info.dart';

import '../model/post_info.dart';
import 'package:http/http.dart' as http;

///
///获取分类文章列表
/// catalog 分类
Future<List<PostInfoBean>> fetchPostListInfo(String catalog) async {
  List<PostInfoBean> _posts = [];

  var url = "data/post_data.json";
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  JsonDecoder jsonDecoder = JsonDecoder();
  Map respMap = jsonDecoder.convert(decoder.convert(response.bodyBytes));

  List jsonList = respMap['data'];

  List<PostInfoBean> postInfoList =
      jsonList.map((e) => PostInfoBean.fromJson(e)).toList();
  // 解析数据

  if (postInfoList.length > 0) {
    if (catalog != "all") {
      postInfoList.forEach((post) {
        if (post.catalog == catalog) {
          _posts.add(post);
        }
      });
    } else {
      _posts = postInfoList;
    }
  }
  return _posts;
}

Future<List<ProjectInfoBean>> fetchProjectListInfo() async {
  var url = "data/project_data.json";
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  JsonDecoder jsonDecoder = JsonDecoder();
  Map respMap = jsonDecoder.convert(decoder.convert(response.bodyBytes));

  List jsonList = respMap['data'];

  List<ProjectInfoBean> _projects =
      jsonList.map((e) => ProjectInfoBean.fromJson(e)).toList();
  return _projects;
}

Future<String> fetchPostContent(String postPath) async {
  var url = postPath;
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  String respContent = decoder.convert(response.bodyBytes);

  return splitFrontMatter(respContent);
}

String splitFrontMatter(String content) {
  var lines = content.split('\n');
  StringBuffer buffer = StringBuffer();
  int splitNum = 0;
  for (int i = 0; i < lines.length; i++) {
    buffer.write(lines[i] + '\n');
    if (lines[i] == "---") {
      splitNum++;
    }
    if (splitNum == 2) {
      break;
    }
  }
  return content.replaceFirst(buffer.toString(), "");
}

Future<Map> fetchBookList() async {
  var url = "/data/booklist_data.json";
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  JsonDecoder jsonDecoder = JsonDecoder();
  Map respMap = jsonDecoder.convert(decoder.convert(response.bodyBytes));
  print(respMap['data'][0]['title']);
  return respMap;
}

Future<List<GalleryInfoBean>> fetchGalleryList() async {
  List<GalleryInfoBean> _galleryList = [];

  var url = "data/gallery_data.json";
  var response = await http.get(url);

  Utf8Decoder decoder = Utf8Decoder();
  JsonDecoder jsonDecoder = JsonDecoder();
  Map respMap = jsonDecoder.convert(decoder.convert(response.bodyBytes));

  List jsonList = respMap['data'];

  List<GalleryInfoBean> galleryInfoList =
      jsonList.map((e) => GalleryInfoBean.fromJson(e)).toList();
  // 解析数据
  print(galleryInfoList[0].title);
  if (galleryInfoList.length > 0) {
    _galleryList = galleryInfoList;
  }
  return _galleryList;
}
