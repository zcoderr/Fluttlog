import 'dart:math';

import 'package:blog/common.dart';
import 'package:flutter/material.dart';

class HeaderHeroImageMobile extends StatelessWidget {
  final String title;
  final String desc;
  static String _randomA = Random().nextInt(182).toString();
  static String _randomB = Random().nextInt(10).toString();

  const HeaderHeroImageMobile(this.title, this.desc, {Key key});

  @override
  Widget build(BuildContext context) {
    common.headerHeight = 400 - 50;
    return Container(
      height: 400,
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
            fit: BoxFit.cover,
            height: 500,
          ),
          Container(
            decoration: BoxDecoration(color: Color(0x55000000)),
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
