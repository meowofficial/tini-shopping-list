import 'dart:async';

import 'package:common/stream/with_previous_stream.dart';
import 'package:common/typedefs/value_with_previous.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../core/base_view_streamable_presenter.dart';
import '../../../../../../core/navigation/desktop/desktop_route_transition.dart';
import '../../../../../../core/navigation/desktop/navigator/desktop_navigator.dart';
import '../../../../../../core/navigation/shared/app_routes.dart';
import '../../../../shared/uri_configs.dart';
import '../../../orchestrator/desktop_navigator_orchestrator/desktop_navigator_orchestrator.dart';
import '../../views/desktop_root_router_view.dart';
import '../desktop_root_router_presenter.dart';

class DesktopRootRouterPresenterImpl extends BaseViewStreamablePresenter<DesktopRootRouterView>
    implements DesktopRootRouterPresenter {
  DesktopRootRouterPresenterImpl({
    required DesktopNavigator navigator,
    required DesktopNavigationOrchestrator navigationOrchestrator,
  }) : _navigator = navigator,
       _navigationOrchestrator = navigationOrchestrator {
    _navigatorUpdateStreamController = StreamController<void>.broadcast();

    final activeRoutes = _filterActiveRoutes(
      routes: _navigator.state.routes,
      routeToTransition: _navigator.state.routeToTransition,
    );

    final view = DesktopRootRouterView(
      routes: _navigator.state.routes,
      activeRoutes: activeRoutes,
      routeToTransition: _navigator.state.routeToTransition,
    );

    initializeView(view);

    _navigatorStateStreamSubscription = _navigator.stateStream
        .withPreviousSeeded(_navigator.state)
        .listen(_onNavigatorStateChanged);
  }

  final DesktopNavigator _navigator;
  final DesktopNavigationOrchestrator _navigationOrchestrator;

  late final StreamController<void> _navigatorUpdateStreamController;

  late final StreamSubscription<ValueWithPrevious<DesktopNavigatorState>>
  _navigatorStateStreamSubscription;

  @override
  Stream<void> get navigatorUpdateStream => _navigatorUpdateStreamController.stream;

  IList<AppRoute> _filterActiveRoutes({
    required IList<AppRoute> routes,
    required IMap<AppRoute, DesktopRouteTransition> routeToTransition,
  }) {
    return routes.where((route) {
      final transition = routeToTransition[route];

      switch (transition) {
        case null:
        case DesktopAdditionRouteTransition():
          return true;

        case DesktopRemovalRouteTransition():
          return false;
      }
    }).toIList();
  }

  void _onNavigatorStateChanged(ValueWithPrevious<DesktopNavigatorState> valueWithPrevious) {
    _navigatorUpdateStreamController.add(null);

    final (currentState, previousState) = valueWithPrevious;

    if (currentState == previousState) {
      return;
    }

    final updatedActiveRoutes = _filterActiveRoutes(
      routes: currentState.routes,
      routeToTransition: currentState.routeToTransition,
    );

    final updatedView = view.copyWith(
      routes: () => currentState.routes,
      routeToTransition: () => currentState.routeToTransition,
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
