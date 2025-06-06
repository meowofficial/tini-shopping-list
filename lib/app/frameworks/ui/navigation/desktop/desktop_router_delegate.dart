import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../interface_adapters/presentation/navigation/desktop/desktop_navigator_presenter.dart';
import '../../../../interface_adapters/presentation/navigation/shared/uri_configs.dart';
import '../shared/navigator_observer.dart';
import '../shared/navigator_page.dart';
import 'desktop_route_transition_delegate.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class DesktopRouterDelegate extends RouterDelegate<UriConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UriConfig> {
  DesktopRouterDelegate({
    required DesktopNavigatorPresenter navigatorPresenter,
  }) : _navigatorPresenter = navigatorPresenter,
       navigatorKey = _navigatorKey;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final DesktopNavigatorPresenter _navigatorPresenter;

  AppNavigatorPage _createNavigatorPage(AppRoute route) {
    final Widget page;

    const fullscreenDialog = false;

    // switch (route) {
    //   default:
    //     throw StateError('Unexpected state');
    // }

    return AppNavigatorPage(
      route: route,
      child: Container(
        color: Colors.black,
      ),
      fullscreenDialog: fullscreenDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _navigatorPresenter.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.data ?? _navigatorPresenter.state;

        final pages = state.routes
            .where((route) {
              return state.routeToTransition[route] is! DesktopRemovalRouteTransition;
            })
            .map(_createNavigatorPage)
            .toList();

        return Navigator(
          key: navigatorKey,
          pages: pages,
          onDidRemovePage: (page) {
            final route = (page as AppNavigatorPage).route;
            print('onDidRemovePage: $route');
          },
          observers: [
            AppNavigatorObserver(
              onPageAddedToNavigator: _navigatorPresenter.onRouteAddedToNavigator,
              onPageRemovedFromNavigator: _navigatorPresenter.onRouteRemovedFromNavigator,
            ),
          ],
          transitionDelegate: DesktopRouteTransitionDelegate(
            routes: state.routes,
            routeToTransition: state.routeToTransition,
          ),
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UriConfig uriConfig) {
    _navigatorPresenter.onPlatformUriConfigChanged(uriConfig);
    return SynchronousFuture(null);
  }

  @override
  UriConfig? get currentConfiguration {
    return _navigatorPresenter.getCurrentUserConfig();
  }
}
