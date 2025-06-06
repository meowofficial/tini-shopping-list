import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../core/application/use_cases/activate_user_intent.dart';
import '../../../../../core/application/user_intents/user_intents.dart';
import '../../../../../core/common/stream/state_streamable.dart';
import '../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../features/shopping_list/application/use_cases/read_active_user_intent.dart';
import '../../../../../features/shopping_list/application/use_cases/watch_active_user_intent.dart';
import '../../../../application/refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../../../../application/use_cases/handle_app_launch.dart';
import '../../../../application/use_cases/read_app_initialization_flow_state.dart';
import '../shared/app_routes.dart';
import '../shared/uri_configs.dart';
import 'desktop_app_routes.dart';
import 'desktop_navigator.dart';

abstract interface class DesktopNavigatorPresenter
    implements StateStreamable<DesktopNavigatorState> {
  void onRouteAddedToNavigator(AppRoute route);

  void onRouteRemovedFromNavigator(AppRoute route);

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUserConfig();
}

class DesktopNavigatorPresenterImpl implements DesktopNavigatorPresenter {
  DesktopNavigatorPresenterImpl({
    required DesktopNavigator desktopNavigator,
    required UuidGenerator uuidGenerator,
    required ActivateUserIntent activateUserIntent,
    required HandleAppLaunch handleAppLaunch,
    required ReadActiveUserIntent readActiveUserIntent,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
    required WatchActiveUserIntent watchActiveUserIntent,
  }) : _desktopNavigator = desktopNavigator,
       _uuidGenerator = uuidGenerator,
       _activateUserIntent = activateUserIntent,
       _handleAppLaunch = handleAppLaunch,
       _readActiveUserIntent = readActiveUserIntent,
       _readAppInitializationFlowState = readAppInitializationFlowState,
       _watchActiveUserIntent = watchActiveUserIntent {
    final appInitializationFlowState = _readAppInitializationFlowState();

    switch (appInitializationFlowState) {
      case InitialAppInitializationFlowStateRef():
      case LoadingAppInitializationFlowStateRef():
        final routes = IList([
          SplashRoute(
            id: _uuidGenerator.generateUuid(),
          ),
        ]);

        const routeToTransition = IMapConst<AppRoute, DesktopRouteTransition>({});

        _desktopNavigator.initialize(
          routes: routes,
          routeToTransition: routeToTransition,
        );

      case LoadedAppInitializationFlowStateRef():
        _updateNavigatorState();
    }

    _activeUserIntent = _readActiveUserIntent();

    _activeUserIntentStreamSubscription = _watchActiveUserIntent().listen(
      _onActiveUserIntentChanged,
    );
  }

  final DesktopNavigator _desktopNavigator;
  final UuidGenerator _uuidGenerator;

  final ActivateUserIntent _activateUserIntent;
  final HandleAppLaunch _handleAppLaunch;
  final ReadActiveUserIntent _readActiveUserIntent;
  final ReadAppInitializationFlowState _readAppInitializationFlowState;
  final WatchActiveUserIntent _watchActiveUserIntent;

  late final StreamSubscription<UserIntent?> _activeUserIntentStreamSubscription;

  late UserIntent? _activeUserIntent;

  @override
  DesktopNavigatorState get state => _desktopNavigator.state;

  @override
  Stream<DesktopNavigatorState> get stateStream => _desktopNavigator.stateStream;

  void _onActiveUserIntentChanged(UserIntent activeUserIntent) {
    _activeUserIntent = activeUserIntent;
  }

  void _updateNavigatorState() {
    final List<AppRoute> desiredRoutes;

    switch (_activeUserIntent!) {
      case ShoppingListOverviewUserIntent():
        desiredRoutes = [
          DesktopShoppingListOverviewRoute(
            id: _uuidGenerator.generateUuid(),
          ),
        ];

      case ShoppingListItemAdditionUserIntent():
        desiredRoutes = [
          DesktopShoppingListOverviewRoute(
            id: _uuidGenerator.generateUuid(),
          ),
        ];

      case ShoppingListItemEditingUserIntent():
        desiredRoutes = [
          DesktopShoppingListOverviewRoute(
            id: _uuidGenerator.generateUuid(),
          ),
        ];
    }

    final routes = _desktopNavigator.state.routes;

    final updatedRoutes = <AppRoute>[];
    final updatedRouteToTransition = _desktopNavigator.state.routeToTransition.unlock;

    const removalRouteTransition = DesktopRemovalRouteTransition(
      displayTransition: false,
    );

    const additionRouteTransition = DesktopAdditionRouteTransition(
      displayTransition: false,
    );

    var foundDesiredRouteCount = 0;
    var processedExistingRouteCount = 0;

    for (final desiredRoute in desiredRoutes) {
      for (var i = processedExistingRouteCount; i < routes.length; i++) {
        final existingRoute = routes[i];

        if (desiredRoute.copyWith(id: () => existingRoute.id) == existingRoute) {
          updatedRouteToTransition[existingRoute] = additionRouteTransition;
          foundDesiredRouteCount++;
        } else {
          updatedRouteToTransition[existingRoute] = removalRouteTransition;
        }

        updatedRoutes.add(existingRoute);

        processedExistingRouteCount++;
      }

      if (processedExistingRouteCount == routes.length) {
        break;
      }
    }

    for (var i = foundDesiredRouteCount; i < desiredRoutes.length; i++) {
      final desiredRoute = desiredRoutes[i];
      updatedRoutes.add(desiredRoute);
      updatedRouteToTransition[desiredRoute] = additionRouteTransition;
    }

    _desktopNavigator.updateWith(
      routes: () => updatedRoutes.lock,
      routeToTransition: () => updatedRouteToTransition.lock,
    );
  }

  @override
  void onRouteAddedToNavigator(AppRoute route) {
    final updatedRouteToTransition = _desktopNavigator.state.routeToTransition.remove(route);

    _desktopNavigator.updateWith(
      routeToTransition: () => updatedRouteToTransition,
    );
  }

  @override
  void onRouteRemovedFromNavigator(AppRoute route) {
    final updatedRoutes = _desktopNavigator.state.routes.remove(route);

    final updatedRouteToTransition = _desktopNavigator.state.routeToTransition.remove(route);

    _desktopNavigator.updateWith(
      routes: () => updatedRoutes,
      routeToTransition: () => updatedRouteToTransition,
    );
  }

  @override
  UriConfig? getCurrentUserConfig() {
    switch (_activeUserIntent) {
      case ShoppingListOverviewUserIntent():
        return const ShoppingListOverviewUriConfig();

      case ShoppingListItemAdditionUserIntent():
        return const ShoppingListItemAdditionUriConfig();

      case ShoppingListItemEditingUserIntent():
        return null;

      case null:
        return null;
    }
  }

  @override
  void onPlatformUriConfigChanged(UriConfig uriConfig) {
    final UserIntent userIntent;

    switch (uriConfig) {
      case ShoppingListOverviewUriConfig():
        userIntent = const ShoppingListOverviewUserIntent();

      case ShoppingListItemAdditionUriConfig():
        userIntent = const ShoppingListItemAdditionUserIntent();
    }

    final appInitializationFlowState = _readAppInitializationFlowState();

    switch (appInitializationFlowState) {
      case InitialAppInitializationFlowStateRef():
        _handleAppLaunch(
          initialUserIntent: userIntent,
        );

      case LoadingAppInitializationFlowStateRef():
        _activateUserIntent(userIntent);

      case LoadedAppInitializationFlowStateRef():
        _updateNavigatorState();
    }
  }

  void dispose() {
    _activeUserIntentStreamSubscription.cancel();
  }
}
