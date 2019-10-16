import 'package:flutter/material.dart';

class SiteHeader extends StatelessWidget {
  final String title;
  final String desc;

  SiteHeader({Key key, this.title, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            child: Image.network(
              'https://storage-1251325576.cos.ap-beijing.myqcloud.com/blog/cover.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
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
          )
        ],
      ),
    );
  }
}
