import 'dart:math';

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeaderHeroImageDesktop extends StatelessWidget {
  final String title;
  final String desc;
  static String _randomA = Random().nextInt(182).toString();
  static String _randomB = Random().nextInt(10).toString();

  const HeaderHeroImageDesktop(this.title, this.desc, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network(
            "http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/" +
                _randomA +
                "/" +
                _randomB +
                "/thumb.jpg",
            fit: BoxFit.fitWidth,
            height: 500,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0x55000000)
            ),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
//                Text(
//                  desc,
//                  style: TextStyle(color: Colors.white, fontSize: 25),
//                ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}
