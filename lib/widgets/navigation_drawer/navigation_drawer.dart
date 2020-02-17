import 'package:blog/routing/route_names.dart';
import 'package:blog/widgets/navbar_item/navbar_item.dart';
import 'package:flutter/material.dart';

import 'navigation_drawer_header.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          NavigationDrawerHeader(),
          // BONUS: Combine the UI for this widget with the NavBarItem and make it responsive.
          // The UI for the current DrawerItem shows when it's in mobile, else it shows the NavBarItem ui.
          NavBarItem(
            '文章',
            PostRoute,
            icon: Icons.videocam,
          ),
          NavBarItem(
            '影集',
            GalleryRoute,
            icon: Icons.help,
          ),
          NavBarItem(
            '项目',
            ProjectRoute,
            icon: Icons.help,
          ),
          NavBarItem(
            '关于',
            AboutRoute,
            icon: Icons.help,
          ),
        ],
      ),
    );
  }
}
