import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/app/navigation/phone/routers/presenters/phone_root_router_presenter.dart';
import 'package:interface_adapters/presentation/app/navigation/shared/uri_configs.dart';
import 'package:interface_adapters/presentation/core/navigation/phone/phone_app_routes.dart';
import 'package:interface_adapters/presentation/core/navigation/shared/app_routes.dart';

import '../../../../core/navigation/phone/phone_route_transition_delegate.dart';
import '../../../../core/navigation/shared/navigator_observer.dart';
import '../../../../core/navigation/shared/navigator_page.dart';
import '../../../../core/utils/view_stream_builder.dart';
import '../../../phone_home_shell_screen/phone_home_shell_screen.dart';
import '../../../splash_screen/splash_screen.dart';

class PhoneRootRouterDelegate extends RouterDelegate<UriConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UriConfig> {
  PhoneRootRouterDelegate({
    required this.presenter,
  }) {
    _navigatorUpdateStreamSubscription = presenter.navigatorUpdateStream.listen(
      (_) => _onNavigatorStateChanged(),
    );
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final PhoneRootRouterPresenter presenter;

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

      case PhoneHomeRoute():
        widget = PhoneHomeShellScreen(
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
          transitionDelegate: PhoneRouteTransitionDelegate(
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
    return presenter.getCurrentUserConfig();
  }
}
