import 'package:blog/widgets/navigation_bar/navbar_logo.dart';
import 'package:flutter/material.dart';

class NavigationBarMobile extends StatelessWidget {
  const NavigationBarMobile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          Text(
            "Zachary's Blog"
          )
          //NavBarLogo()
        ],
      ),
    );
  }
}
