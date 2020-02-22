import 'package:blog/bus.dart';
import 'package:blog/widgets/navigation_bar/navbar_logo.dart';
import 'package:blog/widgets/navigation_drawer/navigation_dialog.dart';
import 'package:flutter/material.dart';

class NavigationBarMobile extends StatefulWidget {
  const NavigationBarMobile({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return NavigationBarMobileState();
  }
}

class NavigationBarMobileState extends State<NavigationBarMobile> {
  bool _isTranslate = true;

  @override
  Widget build(BuildContext context) {
    bus.on(EVENT_NAV_TRANSLATE, (arg) {
      triggerAnimation(arg);
    });

    return Container(
      height: 50,
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          width: 1.0,
          color: _isTranslate ? Colors.transparent : Colors.grey.shade200,
        )),
        color: _isTranslate ? Colors.transparent : Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            child: Text(
              "Zachary's Blog",
              style: TextStyle(
                color: _isTranslate ? Colors.white : Colors.black,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.menu),
            color: _isTranslate ? Colors.white : Colors.black,
            onPressed: () {
              Scaffold.of(context).openEndDrawer();
            },
          ),
        ],
      ),
    );
  }

  void triggerAnimation(bool isTrigger) {
    setState(() {
      this._isTranslate = isTrigger;
    });
  }
}
