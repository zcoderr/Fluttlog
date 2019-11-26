import 'package:blog/model/post_info.dart';
import 'package:flutter/material.dart';

import 'package:blog/data/data_util.dart' as data_util;

// 没有封面图的 post 模块
class PostModuleCard extends StatefulWidget {
  final String catalog;

  const PostModuleCard({Key key, this.catalog}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PostModuleCardState();
  }
}

class PostModuleCardState extends State<PostModuleCard> {
  List<PostInfo> _posts = [];

  @override
  void initState() {
    super.initState();
    data_util.fetchPostListInfo(widget.catalog).then((List<PostInfo> postList) {
      setState(() {
        _posts = postList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Card(
          child: Container(
            padding: EdgeInsets.only(top: 20, bottom: 20),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buidList()),
          ),
        ));
  }

  List<Widget> _buidList() {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < _posts.length; index++) {
      result.add(_buildListItem(_posts[index]));
    }
    return result;
  }

  Widget _buildListItem(PostInfo post) {
    return InkWell(
      onTap: () {},
      child: MediaQuery.of(context).size.width > 800
          ? PostItem(
              post: post,
            )
          : Text("title"),
    );
  }
}

class PostItem extends StatelessWidget {
  final PostInfo post;

  const PostItem({Key key, this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 1000),
      child: Container(
        width: MediaQuery.of(context).size.width * 2 / 3,
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: _buidTagList(post.tags),
            ),
            Text(
              post.title,
              style: TextStyle(fontSize: 16, color: Colors.black87),
            ),
            Text(
              "  " + post.time + "," + post.location,
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buidTagList(List tags) {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < tags.length; index++) {
      result.add(_buildTagItem(tags[index]));
    }
    return result;
  }

  Widget _buildTagItem(String tag) {
    return Padding(
      padding: EdgeInsets.only(left: 3, right: 3),
      child: Container(
        padding: EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          tag,
          style: TextStyle(fontSize: 12),
        ),
      ),
    );
  }
}
