import 'dart:math';

import 'package:blog/common.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderHeroImageMobile extends StatelessWidget {
  final String title;
  final String desc;
 final String imgUrl;

  const HeaderHeroImageMobile(this.title, this.desc, this.imgUrl,{Key key});

  @override
  Widget build(BuildContext context) {
    common.headerHeight = 300 - 50;
    return Container(
      height: 300,
      child: Stack(
        fit: StackFit.passthrough,
        alignment: Alignment.topCenter,
        children: <Widget>[
          Image.network(
            imgUrl,
            fit: BoxFit.cover,
            height: 500,
          ),
          Container(
            decoration: BoxDecoration(color: Color(0x55000000)),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title,
                    style: GoogleFonts.pressStart2P(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                SizedBox(height: 10),
                Text(
                  desc,
                  style: GoogleFonts.cabinSketch(color: Colors.white, fontSize: 20),
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
