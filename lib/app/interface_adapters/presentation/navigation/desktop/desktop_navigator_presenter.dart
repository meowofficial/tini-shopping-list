import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../core/common/stream/state_streamable.dart';
import '../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../features/shopping_list/application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../application/refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../../../../application/use_cases/read_app_initialization_flow_state.dart';
import '../../../../application/use_cases/watch_app_initialization_flow_state.dart';
import '../shared/app_routes.dart';
import '../shared/uri_configs.dart';
import 'desktop_navigator.dart';
import 'desktop_navigator_uri_config_parser_locator.dart';
import 'desktop_navigator_uri_config_parsers.dart';

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
    required DesktopNavigatorUriConfigParserLocator desktopNavigatorUriConfigParserLocator,
    required UuidGenerator uuidGenerator,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required WatchAppInitializationFlowState watchAppInitializationFlowState,
  }) : _desktopNavigator = desktopNavigator,
       _desktopNavigatorUriConfigParserLocator = desktopNavigatorUriConfigParserLocator,
       _uuidGenerator = uuidGenerator,
       _readAppInitializationFlowState = readAppInitializationFlowState,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _watchAppInitializationFlowState = watchAppInitializationFlowState {
    final appInitializationFlowState = _readAppInitializationFlowState();

    switch (appInitializationFlowState) {
      case InitialAppInitializationFlowStateRef():
      case LoadingAppInitializationFlowStateRef():
        _initializeNavigatorState();

      case LoadedAppInitializationFlowStateRef():
        if (_currentUriConfig != null) {
          _syncNavigatorState();
        }
    }
  }

  final DesktopNavigator _desktopNavigator;
  final DesktopNavigatorUriConfigParserLocator _desktopNavigatorUriConfigParserLocator;
  final UuidGenerator _uuidGenerator;

  final ReadAppInitializationFlowState _readAppInitializationFlowState;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final WatchAppInitializationFlowState _watchAppInitializationFlowState;

  UriConfig? _currentUriConfig;

  @override
  DesktopNavigatorState get state => _desktopNavigator.state;

  @override
  Stream<DesktopNavigatorState> get stateStream => _desktopNavigator.stateStream;

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

  void _initializeNavigatorState() {
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
  }

  void _syncNavigatorState() {
    final parser = _desktopNavigatorUriConfigParserLocator.getParserByUriConfig(_currentUriConfig!);

    final requiredRoutes = parser.getRequiredRoutes();
    final existingRoutes = _desktopNavigator.state.routes;

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

    for (final requiredRoute in requiredRoutes) {
      for (var i = processedExistingRouteCount; i < existingRoutes.length; i++) {
        final existingRoute = existingRoutes[i];

        if (requiredRoute.copyWith(id: () => existingRoute.id) == existingRoute) {
          updatedRouteToTransition[existingRoute] = additionRouteTransition;
          foundDesiredRouteCount++;
          updatedRoutes.add(existingRoute);
          processedExistingRouteCount++;
          break;
        }

        updatedRouteToTransition[existingRoute] = removalRouteTransition;
        updatedRoutes.add(existingRoute);
        processedExistingRouteCount++;
      }

      if (processedExistingRouteCount == existingRoutes.length) {
        break;
      }
    }

    for (var i = foundDesiredRouteCount; i < requiredRoutes.length; i++) {
      final requiredRoute = requiredRoutes[i];
      updatedRoutes.add(requiredRoute);
      updatedRouteToTransition[requiredRoute] = additionRouteTransition;
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
    final appInitializationFlowState = _readAppInitializationFlowState();

    switch (appInitializationFlowState) {
      case InitialAppInitializationFlowStateRef():
      case LoadingAppInitializationFlowStateRef():
        return null;

      case LoadedAppInitializationFlowStateRef():
        break;
    }

    final activeRoutes = _filterActiveRoutes(
      routes: _desktopNavigator.state.routes,
      routeToTransition: _desktopNavigator.state.routeToTransition,
    );

    final parsers = _desktopNavigatorUriConfigParserLocator.getAllParsers();

    DesktopNavigatorUriConfigMatchResult? bestMatchResult;

    for (final parser in parsers) {
      final DesktopNavigatorUriConfigMatchResult? matchResult;

      switch (parser) {
        case ShoppingListOverviewUriConfigParser():
          matchResult = parser.tryParse(
            activeRoutes: activeRoutes,
          );

        case ShoppingListItemAdditionUriConfigParser():
          final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

          matchResult = parser.tryParse(
            activeRoutes: activeRoutes,
            shoppingListItemAdditionFlowStateRef: shoppingListItemAdditionFlowStateRef,
          );
      }

      if (matchResult == null) {
        continue;
      }

      if (bestMatchResult == null) {
        bestMatchResult = matchResult;
        continue;
      }

      if (matchResult.matchedRequiredRouteCount < bestMatchResult.matchedRequiredRouteCount) {
        continue;
      }

      if (matchResult.matchedRequiredRouteCount > bestMatchResult.matchedRequiredRouteCount ||
          matchResult.matchedRequiredFlowStateCount >
              bestMatchResult.matchedRequiredFlowStateCount) {
        bestMatchResult = matchResult;
      }
    }

    _currentUriConfig = bestMatchResult?.uriConfig;

    return _currentUriConfig;
  }

  @override
  void onPlatformUriConfigChanged(UriConfig uriConfig) async {
    _currentUriConfig = uriConfig;

    final appInitializationFlowState = _readAppInitializationFlowState();

    if (appInitializationFlowState is! LoadedAppInitializationFlowStateRef) {
      await _watchAppInitializationFlowState().firstWhere((appInitializationFlowStateRef) {
        return appInitializationFlowStateRef is LoadedAppInitializationFlowStateRef;
      });
    }

    if (_currentUriConfig != uriConfig) {
      return;
    }

    switch (uriConfig) {
      case ShoppingListOverviewUriConfig():
        break;

      case ShoppingListItemAdditionUriConfig():
        _startShoppingListItemAddition();
    }

    _syncNavigatorState();
  }
}
