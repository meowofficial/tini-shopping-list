import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../features/shopping_list/frameworks/ui/desktop_shopping_list_item_addition_screen/screen.dart';
import '../../../../../features/shopping_list/frameworks/ui/desktop_shopping_list_overview_screen/screen.dart';
import '../../../../interface_adapters/presentation/navigation/desktop/desktop_app_routes.dart';
import '../../../../interface_adapters/presentation/navigation/desktop/desktop_navigator_presenter.dart';
import '../../../../interface_adapters/presentation/navigation/shared/app_routes.dart';
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
    late final Widget widget;

    const fullscreenDialog = false;

    switch (route) {
      case SplashRoute():
        widget = Container(
          key: Key(route.id),
          color: Colors.white,
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
        throw StateError('Unexpected state: $route');
    }

    return AppNavigatorPage(
      route: route,
      child: widget,
      fullscreenDialog: fullscreenDialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: _navigatorPresenter.state,
      stream: _navigatorPresenter.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.requireData;

        final pages = state.routes
            .where((route) {
              switch (state.routeToTransition[route]) {
                case null:
                case DesktopAdditionRouteTransition():
                  return true;

                case DesktopRemovalRouteTransition():
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

            _navigatorPresenter.onRoutePopped(
              route: route,
            );
          },
          observers: [
            AppNavigatorObserver(
              onPageAddedToNavigator: (route) {
                _navigatorPresenter.onRouteAddedToNavigator(
                  route: route,
                );
              },
              onPageRemovedFromNavigator: (route) {
                _navigatorPresenter.onRouteRemovedFromNavigator(
                  route: route,
                );
              },
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
