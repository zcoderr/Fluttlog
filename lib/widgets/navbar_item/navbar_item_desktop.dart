import 'package:blog/datamodels/navbar_item_model.dart';
import 'package:blog/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_widget.dart';

class NavBarItemTabletDesktop extends ProviderWidget<NavBarItemModel> {
  @override
  Widget build(BuildContext context, NavBarItemModel model) {
    return Column(
      children: <Widget>[
        Text(
          model.title,
          style: TextStyle(fontSize: 18),
        ),
        Container(
          margin: EdgeInsets.only(top: 5),
          height: 2.0,
          width: 30,
          foregroundDecoration:
              BoxDecoration(color: ThemeColors.secondaryColor),
        )
      ],
    );
  }
}
