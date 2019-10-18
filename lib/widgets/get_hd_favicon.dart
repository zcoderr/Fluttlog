import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetFaviconSection extends StatefulWidget {
  @override
  State createState() {
    return GetFaviconState();
  }
}

class GetFaviconState extends State<GetFaviconSection> {
  var placeHolderUrl =
      "https://storage-1251325576.cos.ap-beijing.myqcloud.com/blog/Unknown.png";
  var _iconUrl =
      "https://storage-1251325576.cos.ap-beijing.myqcloud.com/blog/Unknown.png";

  final textEditController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textEditController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _iconUrl == null ? LoadingAnim() : FaviconImg(),
        SizedBox(
          width: 300,
          child: TextField(
            controller: textEditController,
            decoration: InputDecoration(
              hintText: "输入一个网址",
            ),
          ),
        ),
        RaisedButton(
          onPressed: () {
            loadGitHubData(textEditController.text);
            setState(() {
              _iconUrl = null;
            });
          },
          child: Text('获取 LOGO'),
        ),
      ],
    );
  }

  Widget LoadingAnim() {
    return Column(
      children: <Widget>[
        CircularProgressIndicator(),
        Text('解析中...'),
      ],
    );
  }

  Widget FaviconImg() {
    return Column(
      children: <Widget>[
        Image.network(
          _iconUrl,
          width: 300,
          height: 300,
        ),
        Text("Logo地址：" + (_iconUrl == placeHolderUrl ? "" : _iconUrl)),
      ],
    );
  }

  void loadGitHubData(String url) {
    print('请求');
    http
        .get("http://188.131.153.251:8080/favicon?url=" + url)
        .then((http.Response response) {
      JsonDecoder jsonDecoder = JsonDecoder();
      Map respMap = jsonDecoder.convert(response.body);
      // 解析数据
      String iconUrl = respMap['data']['icon'].toString();
      print(iconUrl);
      if (iconUrl.isNotEmpty) {
        setState(() {
          this._iconUrl = iconUrl;
        });
      }
    }).catchError((Error error) {
      print(error.toString());
    });
  }
}
