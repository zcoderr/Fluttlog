import 'package:blog/pages/about_page.dart';
import 'package:blog/pages/essay/essay_list.dart';
import 'package:blog/pages/gallery/gallery_list.dart';
import 'package:blog/pages/post/post_detail_view.dart';
import 'package:blog/pages/project/project_list.dart';
import 'package:blog/routing/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:blog/extensions/string_extensions.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  var routingData = settings.name.getRoutingData; // Get the routing Data
  switch (routingData.route) {
    case PostRoute:
      return _getPageRoute(
          EssayList(
            catalog: "all",
          ),
          settings);
    case GalleryRoute:
      return _getPageRoute(GalleryList(), settings);
    case ProjectRoute:
      return _getPageRoute(ProjectList(), settings);
    case AboutRoute:
      return _getPageRoute(AboutPage(), settings);
    case PostDetailRoute:
      var url = routingData['title'];
      return _getPageRoute(
          PostDetailView(
            url: url,
          ),
          settings);
    default:
      return _getPageRoute(
          EssayList(
            catalog: "all",
          ),
          settings);
  }
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name);
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;

  _FadeRoute({this.child, this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
