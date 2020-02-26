import 'package:blog/pages/gallery/gallery_list_desktop.dart';
import 'package:blog/pages/gallery/gallery_list_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

/// 带封面图的 Post 列表
/// 入参为分类
class GalleryList extends StatelessWidget {
  const GalleryList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: GalleryListMobile(),
      desktop: GalleryListDesktop(),
    );
  }
}
