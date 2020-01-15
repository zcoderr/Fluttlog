import 'package:blog/model/project_info.dart';
import 'dart:html' as html;
import 'package:blog/widgets/footer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:blog/data/data_util.dart' as dataUtils;

/// 带封面图的 Post 列表
/// 入参为分类
class ProjectList extends StatefulWidget {
  const ProjectList({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProjectListState();
  }
}

class ProjectListState extends State<ProjectList> {
  List<ProjectInfoBean> _projects = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    dataUtils.fetchProjectListInfo().then((List<ProjectInfoBean> list) {
      setState(() {
        _projects = list;
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
          return index == _projects.length
              ? Footer()
              : _buildListItem(_projects[index]);
        },
        itemCount: _projects.length + 1,
      ),
    );
  }

  Widget _buildListItem(ProjectInfoBean item) {
    return InkWell(
      onTap: () {
        toDetailPage(item);
      },
      child: MediaQuery.of(context).size.width > 800
          ? buildMaxPostCard(item)
          : buildMinPostCard(item),
    );
  }

  toDetailPage(ProjectInfoBean item) {
    html.window.open(item.url, "");
  }

  Widget buildMaxPostCard(ProjectInfoBean item) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(item.logo),
                              fit: BoxFit.cover))),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            style: TextStyle(
                                fontSize: 20,
                                color: Color(0xff2c3e50),
                                fontWeight: FontWeight.w400),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              item.desc,
                              style: TextStyle(
                                  fontSize: 14, color: Colors.black54),
                            ),
                          ),
                          // 时间和位置
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    padding:
                        EdgeInsets.only(left: 20, right: 20, top: 7, bottom: 7),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Color(0xff69dad8), width: 3.0),
                        borderRadius: BorderRadius.circular(2)),
                    child: Text(
                      'View',
                      style: TextStyle(color: Color(0xff69dad8)),
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

  Widget buildMinPostCard(ProjectInfoBean item) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
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
            child: Container(
              padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
              child: Row(
                children: <Widget>[
                  Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(item.logo),
                              fit: BoxFit.cover))),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.title,
                            style: TextStyle(
                                fontSize: 17,
                                color: Color(0xff2c3e50),
                                fontWeight: FontWeight.w400),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              item.desc,
                              style: TextStyle(
                                  fontSize: 13, color: Colors.black54),
                            ),
                          ),
                          // 时间和位置
                        ],
                      ),
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
