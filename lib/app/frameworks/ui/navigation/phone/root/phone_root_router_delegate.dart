import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/frameworks/ui/navigation/phone/phone_route_transition_delegate.dart';
import '../../../../../../core/frameworks/ui/navigation/shared/navigator_observer.dart';
import '../../../../../../core/frameworks/ui/navigation/shared/navigator_page.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_app_routes.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_route_transition.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../interface_adapters/presentation/navigation/phone/phone_navigator_presenter.dart';
import '../../../../../interface_adapters/presentation/navigation/shared/uri_configs.dart';
import '../../../phone_home_screen/screen.dart';

class PhoneRootRouterDelegate extends RouterDelegate<UriConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UriConfig> {
  PhoneRootRouterDelegate({
    required PhoneNavigatorPresenter navigatorPresenter,
  }) : _navigatorPresenter = navigatorPresenter {
    _navigatorStateStreamSubscription = _navigatorPresenter.stateStream.listen(
      _onNavigatorStateChanged,
    );
  }

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final PhoneNavigatorPresenter _navigatorPresenter;

  late final StreamSubscription<PhoneNavigatorState> _navigatorStateStreamSubscription;

  void _onNavigatorStateChanged(PhoneNavigatorState navigatorState) {
    notifyListeners();
  }

  AppNavigatorPage _createNavigatorPage(AppRoute route) {
    late final Widget widget;

    const fullscreenDialog = false;

    switch (route) {
      case SplashRoute():
        widget = Container(
          key: Key(route.id),
          color: Colors.white,
        );

      case PhoneHomeRoute():
        widget = PhoneHomeScreen(
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
    _navigatorStateStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: _navigatorPresenter.state,
      stream: _navigatorPresenter.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.requireData;

        final pages = state.rootStackState.routes
            .where((route) {
              switch (state.rootStackState.routeToTransition[route]) {
                case null:
                case PhoneAdditionRouteTransition():
                  return true;

                case PhoneRemovalRouteTransition():
                  return false;
              }
            })
            .map(_createNavigatorPage)
            .toList();

        return Navigator(
          key: navigatorKey,
          pages: pages,
          onDidRemovePage: (page) {
            final route = (page as AppNavigatorPage).route;

            _navigatorPresenter.onRootRoutePopped(
              route: route,
            );
          },
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
          transitionDelegate: PhoneRouteTransitionDelegate(
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
