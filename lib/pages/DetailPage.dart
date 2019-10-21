import 'dart:convert';

import 'package:blog/widgets/PostHeader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as markdown;
import 'package:flutter_html/flutter_html.dart' as flutter_html;
import 'package:html/dom.dart' as dom;
import 'dart:html' as html;

class DetailPage extends StatefulWidget {
  final Map post;
  final String catalog;

  const DetailPage({Key key, this.post, this.catalog}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  _DetailPageState();

  @override
  void initState() {
    super.initState();
    loadPostsData();
  }

  String _postContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _postContent == null
            ? CircularProgressIndicator()
            : buildPostBody());
  }

  Widget buildPostBody() {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                PostHeader(
                  title: widget.post['title'],
                  desc: widget.post['desc'],
                  cover: Hero(
                    tag: widget.catalog + widget.post['path'],
                    child: Image.network(
                      widget.post['thumb'],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 1000),
                padding: EdgeInsets.only(left: 25, right: 25, bottom: 50),
                child: flutter_html.Html(
                  data: markdown.markdownToHtml(_postContent),
                  onLinkTap: (url) {
                    //js.context.callMethod("open",[url]);
                    html.window.open(url, "");
                  },
                  padding: EdgeInsets.all(10.0),
                  linkStyle: const TextStyle(
                    color: Colors.green,
                    decorationColor: Colors.redAccent,
                    // decoration: TextDecoration.underline,
                  ),
                  onImageTap: (src) {
                    print(src);
                  },
                  customRender: (node, children) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case "custom_tag":
                          return Column(children: children);
                      }
                    }
                    return null;
                  },
                  customTextAlign: (dom.Node node) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case "p":
                          return TextAlign.justify;
                      }
                    }
                    return null;
                  },
                  customTextStyle: (dom.Node node, TextStyle baseStyle) {
                    if (node is dom.Element) {
                      switch (node.localName) {
                        case "p":
                          return baseStyle
                              .merge(TextStyle(height: 2, fontSize: 20));
                      }
                    }
                    return baseStyle;
                  },
                ),
              ),
            ),
          ],
        ),
        InkWell(
          child: Container(
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Image.asset(
              "images/icon_back.png",
              width: 50,
              height: 50,
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  loadPostsData() {
    http.get("posts" + widget.post['path']).then((http.Response response) {
      Utf8Decoder decoder = Utf8Decoder();
      String respMap = decoder.convert(response.bodyBytes);

      // 解析数据
      String postsData = respMap;
      if (postsData.isNotEmpty) {
        setState(() {
          _postContent = postsData;
        });
      }
      //var div = html.querySelector('selectors');
      //var body = html.Element.html(markdown.markdownToHtml(postsData));
      //div.append(body);
    }).catchError((Error error) {
      print(error.toString());
    });
  }
}
