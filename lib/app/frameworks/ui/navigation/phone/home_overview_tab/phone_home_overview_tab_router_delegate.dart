import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/frameworks/ui/navigation/phone/phone_route_transition_delegate.dart';
import '../../../../../../core/frameworks/ui/navigation/shared/navigator_observer.dart';
import '../../../../../../core/frameworks/ui/navigation/shared/navigator_page.dart';
import '../../../../../../core/frameworks/ui/utils/view_stream_builder.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_app_routes.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../../features/shopping_list/frameworks/ui/phone_shopping_list_overview_screen/screen/screen.dart';
import '../../../../../interface_adapters/presentation/navigation/phone/routers/interfaces/phone_home_overview_tab_router_presenter.dart';

class PhoneHomeOverviewTabRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  PhoneHomeOverviewTabRouterDelegate({
    required this.presenter,
  });

  @override
  final navigatorKey = GlobalKey<NavigatorState>();

  final PhoneHomeOverviewTabRouterPresenter presenter;

  AppNavigatorPage _createNavigatorPage(AppRoute route) {
    late final Widget widget;

    const fullscreenDialog = false;

    switch (route) {
      case PhoneShoppingListOverviewRoute():
        widget = PhoneShoppingListOverviewScreen(
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
