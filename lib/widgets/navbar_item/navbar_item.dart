import 'package:blog/datamodels/navbar_item_model.dart';
import 'package:blog/locator.dart';
import 'package:blog/services/navigation_service.dart';
import 'package:blog/widgets/navbar_item/navbar_item_desktop.dart';
import 'package:blog/widgets/navbar_item/navbar_item_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';

class NavBarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  final IconData icon;

  const NavBarItem(this.title, this.navigationPath, {this.icon});

  @override
  Widget build(BuildContext context) {
    var model = NavBarItemModel(
      title: title,
      navigationPath: navigationPath,
      iconData: icon,
    );
    return GestureDetector(
      onTap: () {
        // DON'T EVER USE A SERVICE DIRECTLY IN THE UI TO CHANGE ANY KIND OF STATE
        // SERVICES SHOULD ONLY BE USED FROM A VIEWMODEL
        locator<NavigationService>().navigateTo(navigationPath);
        if (Scaffold.of(context).isEndDrawerOpen) {
          Scaffold.of(context).openDrawer();
        }
      },
      child: Provider.value(
        value: model,
        child: ScreenTypeLayout(
          tablet: NavBarItemMobile(),
          mobile: NavBarItemMobile(),
        ),
      ),
    );
  }
}
