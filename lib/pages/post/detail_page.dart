import 'package:blog/model/post_info.dart';
import 'package:blog/utils/colors.dart';
import 'package:blog/widgets/footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:markdown/markdown.dart' as markdown;
import 'package:flutter_html/flutter_html.dart' as flutter_html;
import 'package:html/dom.dart' as dom;
import 'dart:html' as html;
import 'package:blog/datamodels/data_util.dart' as dataUtils;

class PostRouteArguments {
  PostRouteArguments({this.post, this.catalog});

  final PostInfoBean post;
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
    dataUtils
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
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 70),
                    child: Text(
                      widget.postDetailArguments.post.title,
                      style: TextStyle(
                          color: ThemeColors.textColor333333,
                          fontSize: FontSize.fontSizeTitleMax),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Image.asset(
                          "images/icon_time.png",
                          width: 15,
                          height: 15,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(
                            widget.postDetailArguments.post.time,
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Image.asset(
                            "images/icon_location.png",
                            width: 15,
                            height: 15,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(
                            widget.postDetailArguments.post.location,
                            style: TextStyle(
                              color: Color(0xff999999),
                              fontWeight: FontWeight.w100,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
        padding: EdgeInsets.only(left: 25, right: 25, bottom: 25,top: 20),
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
                  return baseStyle.merge(TextStyle(
                      height: 2, fontSize: 20, color: ThemeColors.firstColor));
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
        leading: Builder(
             builder: (BuildContext context) {
               return IconButton(
                 icon: Image.asset(
                   "images/icon_back.png",
                   width: 50,
                   height: 50,
                 ),
                 onPressed: () { Navigator.pop(context); },
               );
             },
           ),
        title: Text(widget.postDetailArguments.post.title,style: TextStyle(color: ThemeColors.firstColor),),
        backgroundColor: Colors.white,
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
