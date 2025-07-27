import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:interface_adapters/presentation/app/navigation/phone/routers/presenters/phone_home_addition_tab_router_presenter.dart';
import 'package:interface_adapters/presentation/core/navigation/phone/phone_app_routes.dart';
import 'package:interface_adapters/presentation/core/navigation/shared/app_routes.dart';

import '../../../../core/navigation/phone/phone_route_transition_delegate.dart';
import '../../../../core/navigation/shared/navigator_observer.dart';
import '../../../../core/navigation/shared/navigator_page.dart';
import '../../../../core/utils/view_stream_builder.dart';
import '../../../../shopping_list/phone_shopping_list_item_addition_screen/phone_shopping_list_item_addition_screen.dart';

class PhoneHomeAdditionTabRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  PhoneHomeAdditionTabRouterDelegate({
    required this.presenter,
  });

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final PhoneHomeAdditionTabRouterPresenter presenter;

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
  Future<void> setNewRoutePath(dynamic configuration) {
    return SynchronousFuture(null);
  }
}
