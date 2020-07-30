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
class GalleryListMobile extends StatefulWidget {
  const GalleryListMobile({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GalleryListMobileState();
  }
}

class GalleryListMobileState extends State<GalleryListMobile> {
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
      child: ListView.builder(
        controller: _controller,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          if (index == 0) {
            return HeaderHero.gallery;
          } else if (index == _galleryList.length + 1) {
            return Footer();
          } else {
            return _buildListItem(_galleryList[index - 1]);
          }
        },
        itemCount: _galleryList.length + 2,
      ),
    );
  }

  Widget _buildListItem(GalleryInfoBean item) {
    return GestureDetector(
      onTap: () {
        item.play_url == null ? null : html.window.open(item.play_url, "");
      },
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Image.network(
          item.thumb,
          fit: BoxFit.cover,
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
