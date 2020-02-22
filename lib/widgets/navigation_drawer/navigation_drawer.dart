import 'package:blog/routing/route_names.dart';
import 'package:blog/widgets/navbar_item/navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (Scaffold.of(context).isEndDrawerOpen) {
          Scaffold.of(context).openDrawer();
        }
      },
      child: Container(
        width: 200,
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
          boxShadow: [
            //BoxShadow(color: Colors.black12, blurRadius: 16),
          ],
        ),
        child: Container(
          margin: EdgeInsets.only(top: 50, right: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //NavigationDrawerHeader(),
              // BONUS: Combine the UI for this widget with the NavBarItem and make it responsive.
              // The UI for the current DrawerItem shows when it's in mobile, else it shows the NavBarItem ui.
              NavBarItem(
                '文章',
                PostRoute,
                icon: Icons.import_contacts,
              ),
              NavBarItem(
                '影集',
                GalleryRoute,
                icon: Icons.photo_library,
              ),
              NavBarItem(
                '项目',
                ProjectRoute,
                icon: Icons.work,
              ),
              NavBarItem(
                '关于',
                AboutRoute,
                icon: Icons.info,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
