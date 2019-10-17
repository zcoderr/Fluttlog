import 'dart:convert';

import 'package:blog/pages/DetailPage.dart';
import 'package:blog/widgets/MaxPostCard.dart';
import 'package:blog/widgets/MinPostCard.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostList extends StatefulWidget {
  final String catalog;

  const PostList({Key key, this.catalog}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PostListState();
  }
}

class PostListState extends State<PostList> {
  List posts = [];

  @override
  void initState() {
    super.initState();
    loadPostsData();
  }

  @override
  Widget build(BuildContext context) {
    return getListItems();
  }

  Widget getListItems() {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buidlListItems());
  }

  List<Widget> buidlListItems() {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < posts.length; index++) {
      result.add(getListItem(posts[index]));
    }
    return result;
  }

  Widget getListItem(Map post) {
    return InkWell(
      onTap: () {
        toDetailPage(post);
        // setState(() {
        //   currentPost = post;
        // });
      },
      child: MediaQuery.of(context).size.width > 800
          ? MaxPostCard(post: post)
          : MinPostCard(post: post),
    );
  }

  toDetailPage(Map post) {
    setState(() {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return DetailPage(post: post);
        },
      ));
    });
  }

  loadPostsData() {
    http.get("posts/data.json").then((http.Response response) {
      Utf8Decoder decoder = Utf8Decoder();
      JsonDecoder jsonDecoder = JsonDecoder();
      Map respMap = jsonDecoder.convert(decoder.convert(response.bodyBytes));

      // 解析数据
      List postsData = respMap['data'];
      if (postsData.isNotEmpty) {
        if (widget.catalog != "all") {
          postsData.forEach((post) {
            if (post['catalog'] == widget.catalog) {
              posts.add(post);
              print(post['title']);
            }
          });
        } else {
          posts = postsData;
        }

        setState(() {});
      }
    }).catchError((Error error) {
      print(error.toString());
    });
  }
}
