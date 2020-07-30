import 'package:blog/datamodels/navbar_item_model.dart';
import 'package:flutter/material.dart';
import 'package:provider_architecture/provider_architecture.dart';

class NavBarItemMobile extends ProviderWidget<NavBarItemModel> {
  @override
  Widget build(BuildContext context, NavBarItemModel model) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(model.iconData),
          SizedBox(
            width: 30,
          ),
          Container(
            child: Text(
              model.title,
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
