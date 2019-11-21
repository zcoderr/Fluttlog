import 'package:blog/model/post_info.dart';
import 'package:blog/pages/detail_page.dart';
import 'package:flutter/material.dart';

import '../data_util.dart' as dataUtils;

/// 带封面图的 Post 列表
/// 入参为分类
class PostList extends StatefulWidget {
  final String catalog;

  const PostList({Key key, this.catalog}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PostListState();
  }
}

class PostListState extends State<PostList> {
  List<PostInfo> _posts = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    dataUtils.fetchPostListInfo(widget.catalog).then((List<PostInfo> postList) {
      setState(() {
        _posts = postList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return _buildListItem(_posts[index]);
      },
      itemCount: _posts.length,
    );
  }

  Widget _buildListItem(PostInfo post) {
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

  toDetailPage(PostInfo post) {
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

  Widget buildMaxPostCard(PostInfo post) {
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
                    padding: EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              post.title,
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                post.desc,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            )
                          ],
                        ),
                        // 时间和位置
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                post.time,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                            ),
                            Text(
                              post.location,
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Hero(
                      tag: widget.catalog + post.path,
                      child: Image.network(post.thumb,
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

  Widget buildMinPostCard(PostInfo post) {
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
                  tag: widget.catalog + post.title,
                  child: Image.network(post.thumb, fit: BoxFit.cover),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      post.title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w400),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top: 0),
                          child: Text(
                            post.time,
                            style:
                                TextStyle(color: Colors.black54, fontSize: 14),
                          ),
                        ),
                        Text(
                          post.location,
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ],
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
