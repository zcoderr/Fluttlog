import 'package:blog/model/gallery_info.dart';
import 'package:blog/model/post_info.dart';
import 'package:blog/pages/post/detail_page.dart';
import 'package:blog/widgets/footer.dart';
import 'package:flutter/material.dart';

import 'package:blog/data/data_util.dart' as dataUtils;

/// 带封面图的 Post 列表
/// 入参为分类
class GalleryList extends StatefulWidget {
  const GalleryList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GalleryListState();
  }
}

class GalleryListState extends State<GalleryList> {
  List<PostInfoBean> _galleryList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    dataUtils.fetchGalleryList().then((List<PostInfoBean> galleryList) {
      setState(() {
        _galleryList = galleryList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return index == _galleryList.length
              ? Footer()
              : _buildListItem(_galleryList[index]);
        },
        itemCount: _galleryList.length + 1,
      ),
    );
  }

  Widget _buildListItem(PostInfoBean galleryInfoBean) {
    return InkWell(
      onTap: () {
        //toDetailPage(post);
        // setState(() {
        //   currentPost = post;
        // });
      },
      child: MediaQuery.of(context).size.width > 800
          ? buildMaxPostCard(galleryInfoBean)
          : buildMaxPostCard(galleryInfoBean),
    );
  }

  toDetailPage(PostInfoBean post) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          settings: const RouteSettings(name: "/post"),
          builder: (BuildContext context) => DetailPage(
            postDetailArguments: PostRouteArguments(post: post, catalog: ""),
          ),
        ));

    // Navigator.pushNamed(context, "/post",
    //     arguments: PostRouteArguments(
    //       post: post,
    //       catalog: widget.catalog,
    //     ));
    //String path = "/post/" + post['title'];
  }

  Widget buildMaxPostCard(PostInfoBean item) {
    return Container(
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: Image.network(item.thumb, fit: BoxFit.fitWidth),
          ),
          Container(
            constraints: BoxConstraints(maxWidth: 800),
            padding: EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(
                          fontSize: 23,
                          color: Color(0xff2c3e50),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                // 时间和位置
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "images/icon_time.png",
                        width: 15,
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3),
                        child: Text(
                          item.time,
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
                          item.location,
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
        ],
      ),
    );
  }

  Widget buildMinPostCard(PostInfoBean post) {
    return Container(
      height: 260,
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.04,
          right: MediaQuery.of(context).size.width * 0.04,
          top: 5,
          bottom: 5),
      child: Card(
        // 卡片
        clipBehavior: Clip.antiAlias,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          // 圆角
          borderRadius: BorderRadius.all(
            Radius.circular(4.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 170,
              child: ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Image.network(post.thumb, fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text(
                      post.title,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xff2c3e50),
                          fontWeight: FontWeight.w400),
                    ),
                    // Row(
                    //   children: _buidTagList(post.tags),
                    // ),
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
            color: Colors.blue,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(10)),
        child: Text(
          tag,
          style: TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}

class OverScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
        return child;
      case TargetPlatform.macOS:
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return GlowingOverscrollIndicator(
          child: child,
          //不显示头部水波纹
          showLeading: false,
          //不显示尾部水波纹
          showTrailing: false,
          axisDirection: axisDirection,
          color: Theme.of(context).accentColor,
        );
        break;
    }
    return null;
  }
}
