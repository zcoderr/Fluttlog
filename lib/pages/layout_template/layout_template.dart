import 'package:blog/locator.dart';
import 'package:blog/routing/route_names.dart';
import 'package:blog/routing/router.dart';
import 'package:blog/services/navigation_service.dart';
import 'package:blog/widgets/centered_view/centered_view.dart';
import 'package:blog/widgets/footer.dart';
import 'package:blog/widgets/navigation_bar/navigation_bar.dart';
import 'package:blog/widgets/navigation_drawer/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatelessWidget {
  final Widget child;
  const LayoutTemplate({Key key, this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.Mobile
            ? NavigationDrawer()
            : null,
        backgroundColor: Colors.white,
        body: CenteredView(
          child: Column(
            children: <Widget>[
              NavigationBar(),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

