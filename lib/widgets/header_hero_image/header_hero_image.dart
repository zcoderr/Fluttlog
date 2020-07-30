import 'dart:math';

import 'package:blog/widgets/header_hero_image/header_hero_image_desktop.dart';
import 'package:blog/widgets/header_hero_image/header_hero_image_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeaderHeroImage extends StatelessWidget {
  final String title;
  final String desc;
  final String imgUrl;

  const HeaderHeroImage(this.title, this.desc, this.imgUrl, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HeaderHeroImageMobile(title, desc, imgUrl),
      desktop: HeaderHeroImageDesktop(title, desc, imgUrl),
    );
  }
}

class HeaderHero {
  static String _randomA = Random().nextInt(182).toString();
  static String _randomB = Random().nextInt(10).toString();
  static String imgUrl =
      "http://ppe.oss-cn-shenzhen.aliyuncs.com/collections/" +
          _randomA +
          "/" +
          _randomB +
          "/thumb.jpg";

  static StatelessWidget post =
      HeaderHeroImage("Post", "I can't post everyday.", imgUrl);
  static StatelessWidget gallery =
      HeaderHeroImage("Gallery", "What's the meaning of photography?", imgUrl);
  static StatelessWidget project =
      HeaderHeroImage("Project", "Some of my individual projects.", imgUrl);
  static StatelessWidget about =
      HeaderHeroImage("About", "About me and this website.", imgUrl);
}
