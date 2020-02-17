import 'package:blog/routing/route_names.dart';
import 'package:blog/widgets/navbar_item/navbar_item.dart';
import 'package:flutter/material.dart';

import 'navbar_logo.dart';

class NavigationBarTabletDesktop extends StatelessWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              NavBarItem('文章', PostRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('影集', GalleryRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('项目', ProjectRoute),
              SizedBox(
                width: 60,
              ),
              NavBarItem('About', AboutRoute),
            ],
          )
        ],
      ),
    );
  }
}
