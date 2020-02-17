import 'package:blog/widgets/site_bar/site_bar_desktop.dart';
import 'package:blog/widgets/site_bar/site_bar_mobile.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class SiteBar extends StatelessWidget {
  const SiteBar({Key key}):super(key:key);


  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      desktop: SiteBarDesktop(),
      mobile: SiteBarMobile(),
    );
  }
}
