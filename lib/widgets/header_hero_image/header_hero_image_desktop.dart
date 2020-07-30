import 'dart:math';

import 'package:blog/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeaderHeroImageDesktop extends StatelessWidget {
  final String title;
  final String desc;
  final String imgUrl;

  const HeaderHeroImageDesktop(this.title, this.desc, this.imgUrl, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    common.headerHeight = 500 - 65;
    return Container(
      height: 500,
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network(
            imgUrl,
            fit: BoxFit.fitWidth,
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
                    style: GoogleFonts.pressStart2P(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text(
                    desc,
                    style: GoogleFonts.cabinSketch(
                        color: Colors.white, fontSize: 30),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
