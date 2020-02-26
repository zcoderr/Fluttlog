import 'package:blog/bus.dart';
import 'package:blog/common.dart';
import 'package:blog/model/gallery_info.dart';
import 'package:blog/model/post_info.dart';
import 'package:blog/pages/post/detail_page.dart';
import 'package:blog/utils/colors.dart';
import 'package:blog/widgets/centered_view/centered_view.dart';
import 'package:blog/widgets/footer.dart';
import 'package:blog/widgets/header_hero_image/header_hero_image.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:blog/datamodels/data_util.dart' as dataUtils;

/// 带封面图的 Post 列表
/// 入参为分类
class GalleryListDesktop extends StatefulWidget {
  const GalleryListDesktop({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GalleryListDesktopState();
  }
}

class GalleryListDesktopState extends State<GalleryListDesktop> {
  List<GalleryInfoBean> _galleryList = [];

  ScrollController _controller;
  bool _active = false;

  _scrollListener() {
    if (_controller.offset < common.headerHeight) {
      if (_active) {
        _active = false;
        print("hide action bar");
        bus.emit(EVENT_NAV_TRANSLATE, true);
      }
    } else {
      if (!_active) {
        _active = true;
        print("show action bar");
        bus.emit(EVENT_NAV_TRANSLATE, false);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    initData();
  }

  void initData() {
    dataUtils.fetchGalleryList().then((List<GalleryInfoBean> galleryList) {
      setState(() {
        _galleryList = galleryList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: OverScrollBehavior(),
      child: ListView(
        children: <Widget>[
          HeaderHeroImage("Gallery", "a little of description"),
          CenteredView(
            child: GridView.count(
              shrinkWrap: true,
              // Create a grid with 2 columns. If you change the scrollDirection to
              // horizontal, this produces 2 rows.
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio:3/2,
              // Generate 100 widgets that display their index in the List.
              children: List.generate(_galleryList.length, (index) {
                return _buildListItem(_galleryList[index]);
              }),
            ),
          ),
          Footer(),
        ],
        controller: _controller,
        shrinkWrap: true,
      ),
    );
  }

  Widget _buildListItem(GalleryInfoBean item) {
    return GestureDetector(
      onTap: () {
        item.play_url == null ? null : html.window.open(item.play_url, "");
      },
      child: Image.network(
        item.thumb,
        fit: BoxFit.cover,
      ),
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
            constraints: BoxConstraints(maxWidth: 600),
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
                          color: ThemeColors.firstColor,
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

  Widget buildMinPostCard(GalleryInfoBean item) {}

  Widget _videoCover(GalleryInfoBean item) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Image.network(item.thumb, fit: BoxFit.fitWidth),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(0.0, 1.0),
                colors: <Color>[
                  Colors.black.withOpacity(0.2),
                  Colors.black.withOpacity(0.2),
                  //const Color(0xff000000),
                  //const Color(0xff000000)
                ],
              ),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                "images/icon_play_video.png",
                width: 45,
                height: 45,
              ),
            ),
          ),
        ),
      ],
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
