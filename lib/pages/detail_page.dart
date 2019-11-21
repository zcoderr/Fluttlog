import 'package:blog/model/post_info.dart';
import 'package:blog/widgets/post_header.dart';
import 'package:blog/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:flutter_html/flutter_html.dart' as flutter_html;
import 'package:html/dom.dart' as dom;
import 'dart:html' as html;
import 'package:blog/data_util.dart' as data_util;

class PostRouteArguments {
  PostRouteArguments({this.post, this.catalog});

  final PostInfo post;
  final String catalog;
}

class DetailPage extends StatefulWidget {
  final PostRouteArguments postDetailArguments;
  const DetailPage({Key key, this.postDetailArguments}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<DetailPage> {
  ScrollController _controller;

  bool _active = false;

  _handleActionBarState(bool active) {
    setState(() {
      _active = active;
    });
  }

  _scrollListener() {
    if (_controller.offset < 350) {
      print("hide action bar");
      if (_active) {
        setState(() {
          _active = false;
        });
      }
    } else {
      print("show action bar");
      if (!_active) {
        setState(() {
          _active = true;
        });
      }
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
    initData();
  }

  void initData() {
    data_util
        .fetchPostContent(widget.postDetailArguments.post.path)
        .then((String postContent) {
      setState(() {
        _postContent = postContent;
      });
    });
  }

  String _postContent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        ListView(
          controller: _controller,
          children: <Widget>[
            Stack(
              children: <Widget>[
                PostHeader(
                  title: widget.postDetailArguments.post.title,
                  desc: widget.postDetailArguments.post.desc,
                  cover: Hero(
                    tag: widget.postDetailArguments.catalog +
                        widget.postDetailArguments.post.path,
                    child: Image.network(
                      widget.postDetailArguments.post.thumb,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            _postContent == null
                ? CircularProgressIndicator()
                : _buildPostBody(),
            Footer()
          ],
        ),
        _buildActinBar(),
      ],
    ));
  }

  Widget _buildPostBody() {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1000),
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
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
                  return baseStyle.merge(TextStyle(height: 2, fontSize: 20));
              }
            }
            return baseStyle;
          },
        ),
      ),
    );
  }

  Widget _buildActinBar() {
    return _active
        ? appBar()
        : InkWell(
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
          );
  }

  Widget appBar() {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: AppBar(
        title: Text(widget.postDetailArguments.post.title),
        actions: <Widget>[],
      ),
    );
  }

  Widget actionBar() {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: Row(
          children: <Widget>[
            InkWell(
              child: Container(
                padding: EdgeInsets.only(left: 25),
                child: Image.asset(
                  "images/icon_action_bar_back.png",
                  width: 50,
                  height: 50,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 25),
              child: Text(
                widget.postDetailArguments.post.title,
                style: TextStyle(color: Colors.white, fontSize: 23),
              ),
            )
          ],
        ),
      ),
    );
  }
}
