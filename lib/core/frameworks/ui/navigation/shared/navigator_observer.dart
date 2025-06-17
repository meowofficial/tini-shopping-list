import 'package:flutter/widgets.dart';

import '../../../../interface_adapters/presentation/navigation/shared/app_routes.dart';
import 'navigator_page.dart';

class AppNavigatorObserver extends NavigatorObserver {
  AppNavigatorObserver({
    required this.onPageAddedToNavigator,
    required this.onPageRemovedFromNavigator,
  });

  void Function(AppRoute appRoute) onPageAddedToNavigator;
  void Function(AppRoute appRoute) onPageRemovedFromNavigator;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final appRoute = _getRoutePageModel(route);

    if (appRoute == null) {
      return;
    }

    if (route is TransitionRoute &&
        route.animation != null &&
        route.animation!.status == AnimationStatus.forward) {
      void waitForAnimationCompletion(AnimationStatus animationStatus) {
        if (animationStatus != AnimationStatus.forward) {
          onPageAddedToNavigator(appRoute);
          route.animation?.removeStatusListener(waitForAnimationCompletion);
        }
      }

      route.animation!.addStatusListener(waitForAnimationCompletion);
    } else {
      onPageAddedToNavigator(appRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    final appRoute = _getRoutePageModel(route);

    if (appRoute == null) {
      return;
    }

    if (route is TransitionRoute) {
      await route.completed;
    }

    onPageRemovedFromNavigator(appRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) async {
    final appRoute = _getRoutePageModel(route);

    if (appRoute == null) {
      return;
    }

    if (route is TransitionRoute) {
      await route.completed;
    }

    onPageRemovedFromNavigator(appRoute);
  }

  AppRoute? _getRoutePageModel(Route<dynamic> route) {
    if (route.settings is! AppNavigatorPage) {
      return null;
    }

    final page = route.settings as AppNavigatorPage;

    return page.route;
  }
}
