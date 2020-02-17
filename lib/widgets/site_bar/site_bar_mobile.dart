import 'package:blog/utils/colors.dart';
import 'package:flutter/cupertino.dart';

class SiteBarMobile extends StatelessWidget {
  final String title;
  final String desc;
  final Decoration decoration;
  final Widget tabs;

  SiteBarMobile({Key key, this.title, this.desc, this.decoration, this.tabs})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border:
        Border(bottom: BorderSide(color: Color(0xFFF1F1F1), width: 2.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            child: Text(
              "Zachary's Blog",
              style: MediaQuery.of(context).size.width > 800
                  ? TextStyle(
                  fontSize: 23,
                  color: ThemeColors.firstColor,
                  fontWeight: FontWeight.w500)
                  : TextStyle(fontSize: 16, color: ThemeColors.firstColor),
            ),
          ),
          tabs
        ],
      ),
    );
  }
}
