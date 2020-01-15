import 'package:blog/pages/gallery/gallery_list.dart';
import 'package:blog/pages/project/project_list.dart';
import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'pages/essay/essay_list.dart';
import 'pages/post/detail_page.dart';
import 'pages/post/post_list.dart';
import 'widgets/site_bar.dart';
import 'pages/booklist/book_list.dart';

void main() => runApp(FlutterBlog());

class FlutterBlog extends StatelessWidget {
  Route<Null> _getRoute(RouteSettings settings) {
    switch (settings.name) {
      // case '/post':
      //   return MaterialPageRoute(
      //       settings: const RouteSettings(name: '/post'),
      //       builder: (context) => DetailPage(
      //             postDetailArguments: settings.arguments,
      //           ));
      case 'login':
        return MaterialPageRoute(builder: (context) => DetailPage());
      default:
        return MaterialPageRoute(builder: (context) => DetailPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          // highlightColor: Colors.transparent,
          // splashColor: Colors.transparent
        ),
        title: 'Zachary\'s Blog',
        home: Scaffold(body: Site()),
        initialRoute: "/",
        onGenerateRoute: _getRoute);
  }
}

class Site extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SiteState();
  }
}

class SiteState extends State<Site> {
  int tabIndex = 0;
  static final List<String> items = [
    'POST',
    'GALLERY',
    'PROJECT',
    //'ABOUT',
  ];
  static SiteTab siteTab = SiteTab(
    tabTitles: items,
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 60),
          child: IndexedStack(
            children: <Widget>[
              EssayList(
                catalog: "all",
              ),
              GalleryList(),
              ProjectList(),
              //BookListView(),
              //AboutPage(),
            ],
            index: tabIndex,
          ),
        ),
        SiteBar(
          title: 'Zachary\'s Blog',
          desc: 'Just Empty！',
          tabs: siteTab.copyWith(
            tabTitles: items,
            onTap: (index) {
              setState(() {
                tabIndex = index;
              });
            },
            currentIndex: tabIndex,
          ),
        ),
      ],
    );
  }
}

class SiteTab extends StatelessWidget {
  const SiteTab({
    Key key,
    this.tabTitles,
    this.onTap,
    this.currentIndex = 0,
  });

  final int currentIndex;
  final List<String> tabTitles;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 30),
      child: Row(
        children: MediaQuery.of(context).size.width > 800
            ? _buildMaxTabItems(context)
            : _buildMinTabItems(context),
      ),
    );
  }

  List<Widget> _buildMaxTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < tabTitles.length; index++) {
      result.add(
        GestureDetector(
          onTap: onTap == null
              ? null
              : () {
                  onTap(index);
                },
          child: _buildMaxSingleTabItem(
              index, tabTitles[index], currentIndex == index),
        ),
      );
    }
    return result;
  }

  Widget _buildMaxSingleTabItem(int index, String text, bool active) {
    return Container(
        padding: EdgeInsets.only(left: 25.0, bottom: 5.0, top: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  color: Color(0xff2c3e50),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2.0,
              width: active ? 30 : 0,
              foregroundDecoration: BoxDecoration(color: Color(0xff69dad8)),
            )
          ],
        ));
  }

  List<Widget> _buildMinTabItems(BuildContext context) {
    final List<Widget> result = <Widget>[];

    for (int index = 0; index < tabTitles.length; index++) {
      result.add(
        GestureDetector(
          onTap: onTap == null
              ? null
              : () {
                  onTap(index);
                },
          child: _buildMinSingleTabItem(
              index, tabTitles[index], currentIndex == index),
        ),
      );
    }
    return result;
  }

  Widget _buildMinSingleTabItem(int index, String text, bool active) {
    return Container(
        padding: EdgeInsets.only(left: 10.0, bottom: 5.0, top: 5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              text,
              style: TextStyle(
                  color: Color(0xff2c3e50),
                  fontSize: 13,
                  fontWeight: FontWeight.w400),
            ),
            Container(
              height: 2,
              width: 30,
              margin: EdgeInsets.only(top: 2),
              foregroundDecoration: BoxDecoration(
                  color: active ? Color(0xff69dad8) : Colors.transparent),
            ),
          ],
        ));
  }

  SiteTab copyWith({
    Key key,
    List<String> tabTitles,
    ValueChanged<int> onTap,
    int currentIndex,
  }) {
    return SiteTab(
      key: key ?? this.key,
      tabTitles: tabTitles ?? this.tabTitles,
      onTap: onTap ?? this.onTap,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}
