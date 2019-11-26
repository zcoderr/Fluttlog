import 'package:flutter/material.dart';

import 'pages/about_page.dart';
import 'pages/post/detail_page.dart';
import 'pages/post/post_list.dart';
import 'pages/post/post_module_card.dart';
import 'widgets/site_header.dart';
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
    '首页',
    '文章',
    '影集',
    '项目',
    '书单', 
    '关于',
  ];
  static SiteTab siteTab = SiteTab(
    tabTitles: items,
  );
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true, 
      children: <Widget>[
        Stack(
          children: <Widget>[
            SiteHeader(
              title: 'Zachary\'s Blog',
              desc: 'Just Empty！',
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: siteTab.copyWith(
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
        ),
        IndexedStack(
          children: <Widget>[
            PostModuleCard(
              catalog: "all",
            ),
            PostList(
              catalog: "生活点滴",
            ),
            PostList(
              catalog: "tech",
            ),
            PostList(
              catalog: "photo",
            ),
            BookListView(),
            AboutPage(),
          ],
          index: tabIndex,
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
      padding: EdgeInsets.only(left: 30, bottom: 20),
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
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
      child: Text(
        text,
        style: TextStyle(
            color: active ? Colors.white : Colors.grey,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
    );
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
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 5.0, top: 5.0),
      child: Text(
        text,
        style: TextStyle(
            color: active ? Colors.white : Colors.red,
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),
    );
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
