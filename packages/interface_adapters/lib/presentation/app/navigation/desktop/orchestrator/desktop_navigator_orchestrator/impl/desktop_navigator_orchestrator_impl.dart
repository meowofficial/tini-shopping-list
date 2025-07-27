import 'dart:async';

import 'package:application/app/use_cases/read_app_initialization_flow_state/read_app_initialization_flow_state.dart';
import 'package:application/app/use_cases/shared/refs/app_initialization_flow_state_ref.dart';
import 'package:application/app/use_cases/watch_app_initialization_flow_state/watch_app_initialization_flow_state.dart';
import 'package:application/shopping_list/use_cases/read_shopping_list_item_addition_flow_state/read_shopping_list_item_addition_flow_state.dart';
import 'package:application/shopping_list/use_cases/shared/refs/shopping_list_item_addition_flow_state_ref.dart';
import 'package:application/shopping_list/use_cases/start_shopping_list_item_addition/start_shopping_list_item_addition.dart';
import 'package:application/shopping_list/use_cases/stop_shopping_list_item_addition/stop_shopping_list_item_addition.dart';
import 'package:application/shopping_list/use_cases/watch_shopping_list_item_addition_flow_state/watch_shopping_list_item_addition_flow_state.dart';
import 'package:common/stream/with_previous_stream.dart';
import 'package:common/typedefs/value_with_previous.dart';
import 'package:common/uuid_generator.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/navigation/desktop/desktop_route_transition.dart';
import '../../../../../../core/navigation/desktop/navigator/desktop_navigator.dart';
import '../../../../../../core/navigation/shared/app_routes.dart';
import '../../../../shared/uri_config_holder/uri_config_holder.dart';
import '../../../../shared/uri_configs.dart';
import '../../desktop_navigator_delegates/shopping_list_item_addition_flow_navigator_delegates.dart';
import '../../desktop_navigator_observers.dart';
import '../../desktop_navigator_uri_config_parser_locator/desktop_navigator_uri_config_parser_locator.dart';
import '../../desktop_navigator_uri_config_parsers.dart';
import '../desktop_navigator_orchestrator.dart';

@LazySingleton(as: DesktopNavigationOrchestrator)
class DesktopNavigationOrchestratorImpl implements DesktopNavigationOrchestrator {
  DesktopNavigationOrchestratorImpl({
    required DesktopNavigator navigator,
    required DesktopNavigatorUriConfigParserLocator navigatorUriConfigParserLocator,
    required UriConfigHolder uriConfigHolder,
    required UuidGenerator uuidGenerator,
    required StopShoppingListItemAddition stopShoppingListItemAddition,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required WatchAppInitializationFlowState watchAppInitializationFlowState,
    required WatchShoppingListItemAdditionFlowState watchShoppingListItemAdditionFlowState,
  }) : _navigator = navigator,
       _navigatorUriConfigParserLocator = navigatorUriConfigParserLocator,
       _uriConfigHolder = uriConfigHolder,
       _uuidGenerator = uuidGenerator,
       _stopShoppingListItemAddition = stopShoppingListItemAddition,
       _readAppInitializationFlowState = readAppInitializationFlowState,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _watchAppInitializationFlowState = watchAppInitializationFlowState,
       _watchShoppingListItemAdditionFlowState = watchShoppingListItemAdditionFlowState {
    _navigatorObservers = IList<DesktopNavigatorObserver>([
      ShoppingListItemAdditionStopNavigatorObserver(
        stopShoppingListItemAddition: _stopShoppingListItemAddition,
        readShoppingListItemAdditionFlowState: _readShoppingListItemAdditionFlowState,
      ),
    ]);

    _shoppingListItemAdditionFlowNavigatorDelegates =
        IList<ShoppingListItemAdditionFlowNavigatorDelegate>([
          ShoppingListItemAdditionScreenOpeningNavigatorDelegate(
            navigator: _navigator,
            uuidGenerator: _uuidGenerator,
          ),
          ShoppingListItemAdditionScreenClosingNavigatorDelegate(
            navigator: _navigator,
          ),
        ]);

    final appInitializationFlowStateRef = _readAppInitializationFlowState();

    _syncNavigatorState(
      appInitializationFlowStateRef: appInitializationFlowStateRef,
    );

    _shoppingListItemAdditionFlowStateStreamSubscription = _watchShoppingListItemAdditionFlowState()
        .withPreviousSeeded(_readShoppingListItemAdditionFlowState())
        .listen(_onShoppingListItemAdditionFlowStateChanged);

    _navigatorStateStreamSubscription = _navigator.stateStreamWithPrevious.listen(
      _onNavigatorStateChanged,
    );
  }

  final DesktopNavigator _navigator;
  final DesktopNavigatorUriConfigParserLocator _navigatorUriConfigParserLocator;
  final UriConfigHolder _uriConfigHolder;
  final UuidGenerator _uuidGenerator;

  final StopShoppingListItemAddition _stopShoppingListItemAddition;
  final ReadAppInitializationFlowState _readAppInitializationFlowState;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final WatchAppInitializationFlowState _watchAppInitializationFlowState;
  final WatchShoppingListItemAdditionFlowState _watchShoppingListItemAdditionFlowState;

  late final IList<DesktopNavigatorObserver> _navigatorObservers;
  late final IList<ShoppingListItemAdditionFlowNavigatorDelegate>
  _shoppingListItemAdditionFlowNavigatorDelegates;

  late final StreamSubscription<ValueWithPrevious<ShoppingListItemAdditionFlowStateRef>>
  _shoppingListItemAdditionFlowStateStreamSubscription;

  late final StreamSubscription<ValueWithPrevious<DesktopNavigatorState>>
  _navigatorStateStreamSubscription;

  @override
  DesktopNavigatorState get state => _navigator.state;

  @override
  Stream<DesktopNavigatorState> get stateStream => _navigator.stateStream;

  void _onShoppingListItemAdditionFlowStateChanged(
    ValueWithPrevious<ShoppingListItemAdditionFlowStateRef> valueWithPrevious,
  ) {
    final (currentStateRef, previousStateRef) = valueWithPrevious;

    for (final delegate in _shoppingListItemAdditionFlowNavigatorDelegates) {
      delegate.handleStateChange(
        currentStateRef: currentStateRef,
        previousStateRef: previousStateRef,
      );
    }
  }

  void _onNavigatorStateChanged(ValueWithPrevious<DesktopNavigatorState> valueWithPrevious) {
    final (currentState, previousState) = valueWithPrevious;

    for (final observer in _navigatorObservers) {
      observer.handleStateChange(
        currentState: currentState,
        previousState: previousState,
      );
    }
  }

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

  void _syncNavigatorState({
    required AppInitializationFlowStateRef appInitializationFlowStateRef,
  }) {
    final uriConfig = _uriConfigHolder.lastKnownUriConfig;

    final shouldInitWithSplashScreen = switch (appInitializationFlowStateRef) {
      InitialAppInitializationFlowStateRef() ||
      LoadingAppInitializationFlowStateRef() => !_navigator.initialized,
      LoadedAppInitializationFlowStateRef() => !_navigator.initialized && uriConfig == null,
    };

    if (shouldInitWithSplashScreen) {
      final routes = IList<AppRoute>([
        SplashRoute(
          id: _uuidGenerator.generateUuid(),
        ),
      ]);

      const routeToTransition = IMapConst<AppRoute, DesktopRouteTransition>({});

      _navigator.initialize(
        routes: routes,
        routeToTransition: routeToTransition,
      );

      return;
    }

    final parser = _navigatorUriConfigParserLocator.getParserByUriConfig(
      uriConfig!,
    );

    final requiredRoutes = parser.getRequiredRoutes();

    final navigatorState = _navigator.initialized ? _navigator.state : null;

    final existingRoutes = navigatorState?.routes ?? const IListConst<AppRoute>([]);

    final updatedRoutes = <AppRoute>[];

    final updatedRouteToTransition =
        navigatorState?.routeToTransition.unlock ?? <AppRoute, DesktopRouteTransition>{};

    const removalRouteTransition = DesktopRemovalRouteTransition(
      displayTransition: false,
    );

    const additionRouteTransition = DesktopAdditionRouteTransition(
      displayTransition: false,
    );

    var foundRequiredRouteCount = 0;
    var processedExistingRouteCount = 0;

    for (final requiredRoute in requiredRoutes) {
      for (var i = processedExistingRouteCount; i < existingRoutes.length; i++) {
        final existingRoute = existingRoutes[i];

        final existingRouteActive = switch (updatedRouteToTransition[existingRoute]) {
          null || DesktopAdditionRouteTransition() => true,
          DesktopRemovalRouteTransition() => false,
        };

        if (!existingRouteActive) {
          updatedRoutes.add(existingRoute);
          processedExistingRouteCount++;
          continue;
        }

        if (requiredRoute.copyWith(id: () => existingRoute.id) == existingRoute) {
          foundRequiredRouteCount++;
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

    for (var i = processedExistingRouteCount; i < existingRoutes.length; i++) {
      final existingRoute = existingRoutes[i];
      updatedRouteToTransition[existingRoute] = removalRouteTransition;
      updatedRoutes.add(existingRoute);
      processedExistingRouteCount++;
    }

    for (var i = foundRequiredRouteCount; i < requiredRoutes.length; i++) {
      final requiredRoute = requiredRoutes[i];
      updatedRoutes.add(requiredRoute);
      updatedRouteToTransition[requiredRoute] = additionRouteTransition;
    }

    if (_navigator.initialized) {
      _navigator.updateWith(
        routes: () => updatedRoutes.lock,
        routeToTransition: () => updatedRouteToTransition.lock,
      );
    } else {
      _navigator.initialize(
        routes: updatedRoutes.lock,
        routeToTransition: updatedRouteToTransition.lock,
      );
    }
  }

  @override
  void onRouteAddedToRootNavigator({
    required AppRoute route,
  }) {
    final updatedRouteToTransition = _navigator.state.routeToTransition.remove(route);

    _navigator.updateWith(
      routeToTransition: () => updatedRouteToTransition,
    );
  }

  @override
  void onRouteRemovedFromRootNavigator({
    required AppRoute route,
  }) {
    final updatedRoutes = _navigator.state.routes.remove(route);

    final updatedRouteToTransition = _navigator.state.routeToTransition.remove(route);

    _navigator.updateWith(
      routes: () => updatedRoutes,
      routeToTransition: () => updatedRouteToTransition,
    );
  }

  @override
  void onRootRoutePopped({
    required AppRoute route,
  }) {
    if (!_navigator.state.routes.contains(route)) {
      return;
    }

    final transition = _navigator.state.routeToTransition[route];

    if (transition is DesktopRemovalRouteTransition) {
      return;
    }

    const updatedTransition = DesktopRemovalRouteTransition(
      displayTransition: false,
    );

    final updatedRouteToTransition = _navigator.state.routeToTransition.add(
      route,
      updatedTransition,
    );

    _navigator.updateWith(
      routeToTransition: () => updatedRouteToTransition,
    );
  }

  @override
  UriConfig? getCurrentUserConfig() {
    final appInitializationFlowStateRef = _readAppInitializationFlowState();

    switch (appInitializationFlowStateRef) {
      case InitialAppInitializationFlowStateRef():
      case LoadingAppInitializationFlowStateRef():
        return null;

      case LoadedAppInitializationFlowStateRef():
        break;
    }

    final activeRoutes = _filterActiveRoutes(
      routes: _navigator.state.routes,
      routeToTransition: _navigator.state.routeToTransition,
    );

    final parsers = _navigatorUriConfigParserLocator.getAllParsers();

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

    _uriConfigHolder.lastKnownUriConfig = bestMatchResult?.uriConfig;

    return _uriConfigHolder.lastKnownUriConfig;
  }

  @override
  void onPlatformUriConfigChanged(UriConfig uriConfig) async {
    if (_uriConfigHolder.lastKnownUriConfig == uriConfig) {
      return;
    }

    _uriConfigHolder.lastKnownUriConfig = uriConfig;

    var appInitializationFlowStateRef = _readAppInitializationFlowState();

    if (appInitializationFlowStateRef is! LoadedAppInitializationFlowStateRef) {
      appInitializationFlowStateRef = await _watchAppInitializationFlowState().firstWhere((
        appInitializationFlowStateRef,
      ) {
        return appInitializationFlowStateRef is LoadedAppInitializationFlowStateRef;
      });
    }

    if (_uriConfigHolder.lastKnownUriConfig != uriConfig) {
      return;
    }

    switch (uriConfig) {
      case ShoppingListOverviewUriConfig():
        break;

      case ShoppingListItemAdditionUriConfig():
        _startShoppingListItemAddition();
    }

    _syncNavigatorState(
      appInitializationFlowStateRef: appInitializationFlowStateRef,
    );
  }

  @override
  @disposeMethod
  void dispose() {
    _shoppingListItemAdditionFlowStateStreamSubscription.cancel();
    _navigatorStateStreamSubscription.cancel();
  }
}
