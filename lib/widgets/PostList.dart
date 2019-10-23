import 'dart:convert';
import 'dart:developer';

import 'package:blog/pages/DetailPage.dart';
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
          ? buildMaxPostCard(post)
          : buildMinPostCard(post),
    );
  }

  toDetailPage(Map post) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          settings: const RouteSettings(name: "/post"),
          builder: (BuildContext context) => DetailPage(
            postDetailArguments:
                PostRouteArguments(post: post, catalog: widget.catalog),
          ),
        ));

      // Navigator.pushNamed(context, "/post",
      //     arguments: PostRouteArguments(
      //       post: post,
      //       catalog: widget.catalog,
      //     ));
      //String path = "/post/" + post['title'];
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

  Widget buildMaxPostCard(Map post) {
    return Container(
      height: 300,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05,
          right: MediaQuery.of(context).size.width * 0.05,
          top: 20,
          bottom: 20),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 1000),
          child: Card(
            // 卡片
            clipBehavior: Clip.hardEdge,
            elevation: 5.0,
            shape: new RoundedRectangleBorder(
              // 圆角
              borderRadius: BorderRadius.all(
                Radius.circular(6.0),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(),
              child: Row(
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Container(
                    width: 360,
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          post['title'],
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w400),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 40),
                          child: Text(
                            post['location'],
                            style: TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Hero(
                      tag: widget.catalog + post['path'],
                      child: Image.network(post['thumb'],
                          height: 300, fit: BoxFit.cover),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMinPostCard(Map post) {
    return Container(
      height: 360,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.04,
          top: 20,
          bottom: 20),
      child: Card(
        // 卡片
        clipBehavior: Clip.hardEdge,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          // 圆角
          borderRadius: BorderRadius.all(
            Radius.circular(6.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Hero(
                  tag: widget.catalog + post['title'],
                  child: Image.network(post['thumb'], fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      post['title'],
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        post['location'],
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
