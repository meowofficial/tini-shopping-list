import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/app/navigation/desktop/routers/presenters/desktop_root_router_presenter.dart';
import 'package:interface_adapters/presentation/app/navigation/shared/uri_configs.dart';
import 'package:interface_adapters/presentation/core/navigation/desktop/desktop_app_routes.dart';
import 'package:interface_adapters/presentation/core/navigation/shared/app_routes.dart';

import '../../../core/navigation/desktop/desktop_route_transition_delegate.dart';
import '../../../core/navigation/shared/navigator_observer.dart';
import '../../../core/navigation/shared/navigator_page.dart';
import '../../../core/utils/view_stream_builder.dart';
import '../../../shopping_list/desktop_shopping_list_item_addition_screen/desktop_shopping_list_item_addition_screen.dart';
import '../../../shopping_list/desktop_shopping_list_overview_screen/screen/desktop_shopping_list_overview_screen.dart';
import '../../splash_screen/splash_screen.dart';

class DesktopRootRouterDelegate extends RouterDelegate<UriConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UriConfig> {
  DesktopRootRouterDelegate({
    required this.presenter,
  }) {
    _navigatorUpdateStreamSubscription = presenter.navigatorUpdateStream.listen(
      (_) => _onNavigatorStateChanged(),
    );
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final DesktopRootRouterPresenter presenter;

  late final StreamSubscription<void> _navigatorUpdateStreamSubscription;

  void _onNavigatorStateChanged() {
    notifyListeners();
  }

  AppNavigatorPage _createNavigatorPage(AppRoute route) {
    late final Widget widget;

    const fullscreenDialog = false;

    switch (route) {
      case SplashRoute():
        widget = SplashScreen(
          key: Key(route.id),
        );

      case DesktopShoppingListOverviewRoute():
        widget = DesktopShoppingListOverviewScreen(
          key: Key(route.id),
        );

      case DesktopShoppingListItemAdditionRoute():
        widget = DesktopShoppingListItemAdditionScreen(
          key: Key(route.id),
        );

      default:
        throw StateError('Unexpected route: $route');
    }

    return AppNavigatorPage(
      route: route,
      child: widget,
      fullscreenDialog: fullscreenDialog,
    );
  }

  @override
  void dispose() {
    _navigatorUpdateStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewStreamBuilder(
      viewStreamable: presenter,
      builder: (context, view) {
        final pages = view.activeRoutes.map(_createNavigatorPage).toList();

        return Navigator(
          key: navigatorKey,
          pages: pages,
          onDidRemovePage: (page) {
            final route = (page as AppNavigatorPage).route;
            presenter.onRoutePopped(route);
          },
          observers: [
            AppNavigatorObserver(
              onPageAddedToNavigator: presenter.onRouteAddedToNavigator,
              onPageRemovedFromNavigator: presenter.onRouteRemovedFromNavigator,
            ),
          ],
          transitionDelegate: DesktopRouteTransitionDelegate(
            routes: view.routes,
            routeToTransition: view.routeToTransition,
          ),
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UriConfig uriConfig) {
    presenter.onPlatformUriConfigChanged(uriConfig);
    return SynchronousFuture(null);
  }

  @override
  UriConfig? get currentConfiguration {
    return presenter.getCurrentUriConfig();
  }
}
