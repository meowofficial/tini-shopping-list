import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../app/interface_adapters/presentation/navigation/phone/phone_navigator_presenter.dart';
import '../../../../../../app/interface_adapters/presentation/navigation/shared/uri_configs.dart';
import '../../../../../../core/frameworks/ui/navigation/phone/phone_route_transition_delegate.dart';
import '../../../../../../core/frameworks/ui/navigation/shared/navigator_observer.dart';
import '../../../../../../core/frameworks/ui/navigation/shared/navigator_page.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_app_routes.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_route_transition.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../../features/shopping_list/frameworks/ui/phone_shopping_list_item_addition_screen/screen.dart';

class PhoneHomeAdditionTabRouterDelegate extends RouterDelegate<UriConfig>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UriConfig> {
  PhoneHomeAdditionTabRouterDelegate({
    required PhoneNavigatorPresenter navigatorPresenter,
  }) : _navigatorPresenter = navigatorPresenter;

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final PhoneNavigatorPresenter _navigatorPresenter;

  AppNavigatorPage _createNavigatorPage(AppRoute route) {
    late final Widget widget;

    const fullscreenDialog = false;

    switch (route) {
      case PhoneShoppingListItemAdditionRoute():
        widget = PhoneShoppingListItemAdditionScreen(
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
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: _navigatorPresenter.state,
      stream: _navigatorPresenter.stateStream,
      builder: (context, snapshot) {
        final state = snapshot.requireData;

        final stackState = state.homeNavigationState!.tabStackStateMap[PhoneHomeTab.addition]!;

        final pages = stackState.routes
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

            _navigatorPresenter.onHomeTabRoutePopped(
              route: route,
              homeTab: PhoneHomeTab.addition,
            );
          },
          observers: [
            AppNavigatorObserver(
              onPageAddedToNavigator: (route) {
                _navigatorPresenter.onRouteAddedToHomeTabNavigator(
                  route: route,
                  homeTab: PhoneHomeTab.addition,
                );
              },
              onPageRemovedFromNavigator: (route) {
                _navigatorPresenter.onRouteRemovedFromHomeTabNavigator(
                  route: route,
                  homeTab: PhoneHomeTab.addition,
                );
              },
            ),
          ],
          transitionDelegate: PhoneRouteTransitionDelegate(
            routes: stackState.routes,
            routeToTransition: stackState.routeToTransition,
          ),
        );
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UriConfig uriConfig) {
    return SynchronousFuture(null);
  }
}
