import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/phone/phone_route_transition.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../orchestrator/phone_navigation_orchestrator.dart';
import '../interfaces/phone_home_addition_tab_router_presenter.dart';
import '../views/phone_home_addition_tab_router_view.dart';

class PhoneHomeAdditionTabRouterPresenterImpl
    extends BaseViewStreamablePresenter<PhoneHomeAdditionTabRouterView>
    implements PhoneHomeAdditionTabRouterPresenter {
  PhoneHomeAdditionTabRouterPresenterImpl({
    required PhoneNavigator navigator,
    required PhoneNavigationOrchestrator navigationOrchestrator,
  }) : _navigator = navigator,
       _navigationOrchestrator = navigationOrchestrator {
    final navigatorStackState =
        _navigator.state.homeNavigationState!.tabStackStateMap[PhoneHomeTab.addition]!;

    final activeRoutes = _filterActiveRoutes(
      routes: navigatorStackState.routes,
      routeToTransition: navigatorStackState.routeToTransition,
    );

    final view = PhoneHomeAdditionTabRouterView(
      routes: navigatorStackState.routes,
      activeRoutes: activeRoutes,
      routeToTransition: navigatorStackState.routeToTransition,
    );

    initializeView(view);

    _navigatorStateStreamSubscription = _navigator.stateStream
        .withPreviousSeeded(_navigator.state)
        .listen(_onNavigatorStateChanged);
  }

  final PhoneNavigator _navigator;
  final PhoneNavigationOrchestrator _navigationOrchestrator;

  late final StreamSubscription<ValueWithPrevious<PhoneNavigatorState>>
  _navigatorStateStreamSubscription;

  IList<AppRoute> _filterActiveRoutes({
    required IList<AppRoute> routes,
    required IMap<AppRoute, PhoneRouteTransition> routeToTransition,
  }) {
    return routes.where((route) {
      final transition = routeToTransition[route];

      switch (transition) {
        case null:
        case PhoneAdditionRouteTransition():
          return true;

        case PhoneRemovalRouteTransition():
          return false;
      }
    }).toIList();
  }

  void _onNavigatorStateChanged(ValueWithPrevious<PhoneNavigatorState> valueWithPrevious) {
    final (currentState, previousState) = valueWithPrevious;

    final currentNavigatorStackState =
        currentState.homeNavigationState!.tabStackStateMap[PhoneHomeTab.addition]!;

    final previousNavigatorStackState =
        previousState.homeNavigationState!.tabStackStateMap[PhoneHomeTab.addition]!;

    if (currentNavigatorStackState == previousNavigatorStackState) {
      return;
    }

    final updatedActiveRoutes = _filterActiveRoutes(
      routes: currentNavigatorStackState.routes,
      routeToTransition: currentNavigatorStackState.routeToTransition,
    );

    final updatedView = view.copyWith(
      routes: () => currentNavigatorStackState.routes,
      routeToTransition: () => currentNavigatorStackState.routeToTransition,
      activeRoutes: () => updatedActiveRoutes,
    );

    emit(updatedView);
  }

  @override
  void onRoutePopped(AppRoute route) {
    _navigationOrchestrator.onHomeTabRoutePopped(
      route: route,
      homeTab: PhoneHomeTab.addition,
    );
  }

  @override
  void onRouteAddedToNavigator(AppRoute route) {
    _navigationOrchestrator.onRouteAddedToHomeTabNavigator(
      route: route,
      homeTab: PhoneHomeTab.addition,
    );
  }

  @override
  void onRouteRemovedFromNavigator(AppRoute route) {
    _navigationOrchestrator.onRouteRemovedFromHomeTabNavigator(
      route: route,
      homeTab: PhoneHomeTab.addition,
    );
  }

  @override
  void dispose() {
    _navigatorStateStreamSubscription.cancel();
    super.dispose();
  }
}
