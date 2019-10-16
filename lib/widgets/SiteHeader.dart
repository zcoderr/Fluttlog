import 'package:flutter/material.dart';

class SiteHeader extends StatelessWidget {
  final String title;
  final String desc;
  final String cover;
  final Decoration decoration;

  SiteHeader({Key key, this.title, this.desc, this.cover,this.decoration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: Image.network(
              cover,
              fit: BoxFit.cover,
            ),
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
