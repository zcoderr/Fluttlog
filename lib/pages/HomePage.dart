import 'dart:convert';

import 'package:blog/pages/DetailPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  List posts = [];
  Map currentPost;

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
    return currentPost == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: buidlListItems())
        : DetailPage(
            post: currentPost,
          );
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
          ? buildMaxCard(post)
          : buildMinCard(post),
    );
  }

  Widget buildMaxCard(Map post) {
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
                    child: Image.network(post['thumb'],
                        height: 300, fit: BoxFit.cover),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildMinCard(Map post) {
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
                child: Image.network(post['thumb'], fit: BoxFit.cover),
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
        setState(() {
          posts = postsData;
        });
      }
    }).catchError((Error error) {
      print(error.toString());
    });
  }
}
