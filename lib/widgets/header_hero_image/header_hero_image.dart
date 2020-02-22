import 'package:blog/widgets/header_hero_image/header_hero_image_desktop.dart';
import 'package:blog/widgets/header_hero_image/header_hero_image_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class HeaderHeroImage extends StatelessWidget {
  final String title;
  final String desc;

  const HeaderHeroImage(this.title, this.desc, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: HeaderHeroImageMobile(title, desc),
      desktop: HeaderHeroImageDesktop(title, desc),
    );
  }
}
