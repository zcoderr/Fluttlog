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

class PostDetailView extends StatefulWidget {
  final String url;

  const PostDetailView({Key key, this.url}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }
}

class _DetailPageState extends State<PostDetailView> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    print("获取到URl" + widget.url);
    dataUtils.fetchPostInfoByUrl(widget.url).then((PostInfoBean postInfoBean) {
      dataUtils.fetchPostContent(postInfoBean.path).then((String postContent) {
        setState(() {
          _postContent = postContent;
        });
      });
      setState(() {
        _postInfoBean = postInfoBean;
      });
    });
  }

  String _postContent;
  PostInfoBean _postInfoBean;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ListView(
          children: <Widget>[
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 70),
                    child: Text(
                      _postInfoBean.title,
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
                            _postInfoBean.time,
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
                            _postInfoBean.location,
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
      ],
    );
  }

  Widget _buildPostBody() {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1000),
        padding: EdgeInsets.only(bottom: 25, top: 20),
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
}
