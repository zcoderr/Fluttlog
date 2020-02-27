import 'package:blog/common.dart';
import 'package:blog/model/post_info.dart';
import 'package:blog/utils/colors.dart';
import 'package:blog/viewmodels/post_list_view_model.dart';
import 'package:blog/widgets/footer.dart';
import 'package:blog/widgets/header_hero_image/header_hero_image.dart';
import 'package:blog/widgets/header_hero_image/header_hero_image_desktop.dart';
import 'package:flutter/material.dart';
import 'package:blog/bus.dart';
import 'package:blog/datamodels/data_util.dart' as dataUtils;
import 'package:provider_architecture/provider_architecture.dart';

class EssayList extends StatefulWidget {
  final String catalog;

  const EssayList({Key key, this.catalog}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EssayListState();
  }
}

class EssayListState extends State<EssayList> {
  List<PostInfoBean> _posts = [];

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
    dataUtils
        .fetchPostListInfo(widget.catalog)
        .then((List<PostInfoBean> postList) {
      setState(() {
        _posts = postList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade50,
      child: ViewModelProvider<PostListViewModel>.withConsumer(
          viewModel: PostListViewModel(),
          builder: (context, model, child) => ScrollConfiguration(
                behavior: OverScrollBehavior(),
                child: ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return HeaderHeroImage("Post", "a little of description");
                    } else if (index == _posts.length + 1) {
                      return Footer();
                    } else {
                      return _buildListItem(_posts[index - 1], model);
                    }
                  },
                  itemCount: _posts.length + 2,
                ),
              )),
    );
  }

  Widget _buildListItem(PostInfoBean post, PostListViewModel model) {
    return GestureDetector(
      onTap: () {
        //toDetailPage(post);
        // setState(() {
        //   currentPost = post;
        // });
        model.navigateToEpisode(post.url);
      },
      child: MediaQuery.of(context).size.width > 800
          ? buildMaxPostCard(post)
          : buildMinPostCard(post),
    );
  }

  toDetailPage(PostInfoBean post) {
//    Navigator.push(
//        context,
//        MaterialPageRoute<void>(
//          //settings: const RouteSettings(name: "/post"),
//          builder: (BuildContext context) => DetailPage(
//            postDetailArguments:
//                PostRouteArguments(post: post, catalog: widget.catalog),
//          ),
//        ));

    // Navigator.pushNamed(context, "/post",
    //     arguments: PostRouteArguments(
    //       post: post,
    //       catalog: widget.catalog,
    //     ));
    //String path = "/post/" + post['title'];
  }

  Widget buildMaxPostCard(PostInfoBean post) {
    return Center(
      child: Container(
        constraints: BoxConstraints(maxWidth: 1000),
        child: Card(
          // 卡片
          margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
          clipBehavior: Clip.antiAlias,
          elevation: 0,
          shape: new RoundedRectangleBorder(
            // 圆角
            borderRadius: BorderRadius.all(
              Radius.circular(6.0),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  post.title,
                  style: TextStyle(
                      fontSize: 23,
                      color: ThemeColors.firstColor,
                      fontWeight: FontWeight.w400),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    post.desc,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xff555555),
                        fontWeight: FontWeight.w300),
                  ),
                ),
                // 时间和位置
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        "images/icon_time.png",
                        width: 15,
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 3),
                        child: Text(
                          post.time,
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
                          post.location,
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
        ),
      ),
    );
  }

  Widget buildMinPostCard(PostInfoBean post) {
    return Container(
      margin: EdgeInsets.only(left: 5, right: 5),
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
                Radius.circular(4.0),
              ),
            ),
            child: Container(
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    post.title,
                    style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff2c3e50),
                        fontWeight: FontWeight.w400),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 7),
                    child: Text(
                      post.desc,
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff555555),
                          fontWeight: FontWeight.w200),
                    ),
                  ),
                  // 时间和位置
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          "images/icon_time.png",
                          width: 13,
                          height: 13,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(
                            post.time,
                            style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Image.asset(
                            "images/icon_location.png",
                            width: 13,
                            height: 13,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 3),
                          child: Text(
                            post.location,
                            style: TextStyle(
                                color: Color(0xff999999),
                                fontSize: 12,
                                fontWeight: FontWeight.w200),
                          ),
                        ),
                      ],
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
