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
    dataUtils
        .fetchGalleryList()
        .then((List<PostInfoBean> galleryList) {
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
            postDetailArguments:
                PostRouteArguments(post: post, catalog: ""),
          ),
        ));

    // Navigator.pushNamed(context, "/post",
    //     arguments: PostRouteArguments(
    //       post: post,
    //       catalog: widget.catalog,
    //     ));
    //String path = "/post/" + post['title'];
  }

  Widget buildMaxPostCard(PostInfoBean galleryInfoBean) {
    return Container(
      height: 500,
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
            clipBehavior: Clip.antiAlias,
            elevation: 0.0,
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
                              galleryInfoBean.title,
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Color(0xff2c3e50),
                                  fontWeight: FontWeight.w400),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(
                                galleryInfoBean.desc,
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black54),
                              ),
                            ),
                            // Container(
                            //   padding: EdgeInsets.only(top: 10),
                            //   child: Row(
                            //     children: _buidTagList(post.tags),
                            //   ),
                            // ),
                          ],
                        ),
                        // 时间和位置
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(top: 0),
                              child: Text(
                                galleryInfoBean.time,
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 14),
                              ),
                            ),
                            Text(
                              galleryInfoBean.location,
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
                      tag: "",
                      child: Image.network(galleryInfoBean.thumb,
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
