import 'package:blog/bus.dart';
import 'package:blog/datamodels/navbar_item_model.dart';
import 'package:blog/locator.dart';
import 'package:blog/services/navigation_service.dart';
import 'package:blog/utils/colors.dart';
import 'package:blog/widgets/navbar_item/navbar_item_desktop.dart';
import 'package:blog/widgets/navbar_item/navbar_item_mobile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:blog/extensions/hover_extensions.dart';

class NewNavBarItemDesktop extends StatefulWidget {
  final String title;
  final String navigationPath;
  final IconData icon;
  final bool isSelect;
  final bool isTranslate;

  const NewNavBarItemDesktop(
      this.title, this.navigationPath, this.isTranslate, this.isSelect,
      {this.icon});

  @override
  State<StatefulWidget> createState() {
    return NewNavBarItemDesktopState();
  }
}

class NewNavBarItemDesktopState extends State<NewNavBarItemDesktop> {
  @override
  Widget build(BuildContext context) {
    var model = NavBarItemModel(
      title: widget.title,
      navigationPath: widget.navigationPath,
      iconData: widget.icon,
    );
    return GestureDetector(
      onTap: () {
        // DON'T EVER USE A SERVICE DIRECTLY IN THE UI TO CHANGE ANY KIND OF STATE
        // SERVICES SHOULD ONLY BE USED FROM A VIEWMODEL
        locator<NavigationService>().navigateTo(widget.navigationPath);
        bus.emit(EVENT_NAV_TRANSLATE,true);
        if (Scaffold.of(context).isEndDrawerOpen) {
          Scaffold.of(context).openDrawer();
        }
      },
      child: Provider.value(
        value: model,
        child: Container(
          decoration: BoxDecoration(color: Colors.transparent),
          padding: EdgeInsets.all(5),
          child: Text(
            model.title,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: widget.isTranslate ? Colors.white : Colors.black),
          ),
        ).showCursorOnHover.moveUpOnHover,
      ),
    );
  }
}
