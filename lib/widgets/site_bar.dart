import 'package:flutter/material.dart';

class SiteBar extends StatelessWidget {
  final String title;
  final String desc;
  final Decoration decoration;
  final Widget tabs;

  SiteBar({Key key, this.title, this.desc, this.decoration, this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Text(
              "Zachary's Blog",
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
          ),
          tabs
        ],
      ),
    );
  }
}
