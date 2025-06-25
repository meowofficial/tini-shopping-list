import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../../../../core/interface_adapters/presentation/base_view_streamable_presenter.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/phone/phone_route_transition.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../shared/uri_configs.dart';
import '../../orchestrator/phone_navigation_orchestrator.dart';
import '../interfaces/phone_root_router_presenter.dart';
import '../views/phone_root_router_view.dart';

class PhoneRootRouterPresenterImpl extends BaseViewStreamablePresenter<PhoneRootRouterView>
    implements PhoneRootRouterPresenter {
  PhoneRootRouterPresenterImpl({
    required PhoneNavigator navigator,
    required PhoneNavigationOrchestrator navigationOrchestrator,
  }) : _navigator = navigator,
       _navigationOrchestrator = navigationOrchestrator {
    _navigatorUpdateStreamController = StreamController<void>.broadcast();

    final navigatorStackState = _navigator.state.rootStackState;

    final activeRoutes = _filterActiveRoutes(
      routes: navigatorStackState.routes,
      routeToTransition: navigatorStackState.routeToTransition,
    );

    final view = PhoneRootRouterView(
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

  late final StreamController<void> _navigatorUpdateStreamController;

  late final StreamSubscription<ValueWithPrevious<PhoneNavigatorState>>
  _navigatorStateStreamSubscription;

  @override
  Stream<void> get navigatorUpdateStream => _navigatorUpdateStreamController.stream;

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
    _navigatorUpdateStreamController.add(null);

    final (currentState, previousState) = valueWithPrevious;

    final currentNavigatorStackState = currentState.rootStackState;

    final previousNavigatorStackState = previousState.rootStackState;

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
    _navigationOrchestrator.onRootRoutePopped(
      route: route,
    );
  }

  @override
  void onRouteAddedToNavigator(AppRoute route) {
    _navigationOrchestrator.onRouteAddedToRootNavigator(
      route: route,
    );
  }

  @override
  void onRouteRemovedFromNavigator(AppRoute route) {
    _navigationOrchestrator.onRouteRemovedFromRootNavigator(
      route: route,
    );
  }

  @override
  UriConfig? getCurrentUserConfig() {
    return _navigationOrchestrator.getCurrentUserConfig();
  }

  @override
  void onPlatformUriConfigChanged(UriConfig uriConfig) {
    _navigationOrchestrator.onPlatformUriConfigChanged(uriConfig);
  }

  @override
  void dispose() {
    _navigatorUpdateStreamController.close();
    _navigatorStateStreamSubscription.cancel();
    super.dispose();
  }
}
