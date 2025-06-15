import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../interface_adapters/presentation/navigation/mobile/mobile_navigator_presenter.dart';
import '../../../../interface_adapters/presentation/navigation/shared/uri_configs.dart';
import '../shared/navigator_observer.dart';
import '../shared/navigator_page.dart';
import 'mobile_route_transition_delegate.dart';

final _navigatorKey = GlobalKey<NavigatorState>();

class MobileRootRouterDelegate extends RouterDelegate<UriConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UriConfig> {
  MobileRootRouterDelegate({
    required MobileNavigatorPresenter navigatorPresenter,
  }) : _navigatorPresenter = navigatorPresenter,
       navigatorKey = _navigatorKey;

  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final MobileNavigatorPresenter _navigatorPresenter;

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

        final pages = state.rootStackState.routes
            .where((route) {
              switch (state.rootStackState.routeToTransition[route]) {
                case null:
                case MobileAdditionRouteTransition():
                  return true;

                case MobileRemovalRouteTransition():
                  return false;
              }
            })
            .map(_createNavigatorPage)
            .toList();

        return Navigator(
          key: navigatorKey,
          pages: pages,
          observers: [
            AppNavigatorObserver(
              onPageAddedToNavigator: (route) {
                _navigatorPresenter.onRouteAddedToRootNavigator(
                  route: route,
                );
              },
              onPageRemovedFromNavigator: (route) {
                _navigatorPresenter.onRouteRemovedFromRootNavigator(
                  route: route,
                );
              },
            ),
          ],
          transitionDelegate: MobileRouteTransitionDelegate(
            routes: state.rootStackState.routes,
            routeToTransition: state.rootStackState.routeToTransition,
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
