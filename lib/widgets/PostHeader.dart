import 'package:flutter/material.dart';

class PostHeader extends StatelessWidget {
  final String title;
  final String desc;
  final Widget cover;
  final Decoration decoration;

  PostHeader({Key key, this.title, this.desc, this.cover,this.decoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: cover,
          ),
          Container(
            decoration:decoration,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.bold)),
                  Text(desc,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.normal)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
