import 'package:flutter/cupertino.dart';

import '../locator.dart';
import '../routing/route_names.dart';
import '../services/navigation_service.dart';

class PostListViewModel extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();

  void navigateToEpisode(String title) {
    _navigationService
        .navigateTo(PostDetailRoute, queryParams: {'title': title});
  }
}
