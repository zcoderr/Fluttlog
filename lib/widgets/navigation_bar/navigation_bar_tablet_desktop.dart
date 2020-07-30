import 'package:blog/routing/route_names.dart';
import 'package:blog/widgets/centered_view/centered_view.dart';
import 'package:blog/widgets/navbar_item/new_navbar_item_desktop.dart';
import 'package:flutter/material.dart';
import 'package:blog/bus.dart';
import 'navbar_logo.dart';

class NavigationBarTabletDesktop extends StatefulWidget {
  const NavigationBarTabletDesktop({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NavigationBarDesktopState();
  }
}

class NavigationBarDesktopState extends State<NavigationBarTabletDesktop> {
  bool _isTranslate = true;

  Widget build(BuildContext context) {
    bus.on(EVENT_NAV_TRANSLATE, (arg) {
      triggerAnimation(arg);
    });

    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 1.0,
          color: _isTranslate ? Colors.transparent : Colors.grey.shade200,
        )),
        color: _isTranslate ? Colors.transparent : Colors.white,
      ),
      height: 65,
      child: CenteredView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Zachary's Blog",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: _isTranslate ? Colors.white : Colors.black,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                NewNavBarItemDesktop('Post', PostRoute, _isTranslate, false),
                SizedBox(
                  width: 40,
                ),
                NewNavBarItemDesktop(
                    'Project', ProjectRoute, _isTranslate, false),
                SizedBox(
                  width: 40,
                ),
                NewNavBarItemDesktop(
                    'Gallery', GalleryRoute, _isTranslate, false),
                SizedBox(
                  width: 40,
                ),
                NewNavBarItemDesktop('About', AboutRoute, _isTranslate, false),
              ],
            )
          ],
        ),
      ),
    );
  }

  void triggerAnimation(bool isTrigger) {
    setState(() {
      this._isTranslate = isTrigger;
    });
  }
}
