import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../core/common/disposable.dart';
import '../../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_app_routes.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_navigator.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_route_transition.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../../features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../../features/shopping_list/application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../../../features/shopping_list/application/use_cases/suspend_shopping_list_item_addition.dart';
import '../../../../../application/refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../../../../../application/use_cases/read_app_initialization_flow_state.dart';
import '../../../../../application/use_cases/watch_app_initialization_flow_state.dart';
import '../../shared/uri_config_holder.dart';
import '../../shared/uri_configs.dart';
import 'phone_navigator_observers.dart';
import 'phone_navigator_uri_config_parser_locator.dart';
import 'phone_navigator_uri_config_parsers.dart';

abstract interface class PhoneNavigationOrchestrator implements Disposable {
  void onRouteAddedToRootNavigator({
    required AppRoute route,
  });

  void onRouteRemovedFromRootNavigator({
    required AppRoute route,
  });

  void onRootRoutePopped({
    required AppRoute route,
  });

  void onRouteAddedToHomeTabNavigator({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  });

  void onRouteRemovedFromHomeTabNavigator({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  });

  void onHomeTabRoutePopped({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  });

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUserConfig();
}

@LazySingleton(as: PhoneNavigationOrchestrator)
class PhoneNavigationOrchestratorImpl implements PhoneNavigationOrchestrator {
  PhoneNavigationOrchestratorImpl({
    required PhoneNavigator phoneNavigator,
    required PhoneNavigatorUriConfigParserLocator phoneNavigatorUriConfigParserLocator,
    required UriConfigHolder uriConfigHolder,
    required UuidGenerator uuidGenerator,
    required SuspendShoppingListItemAddition suspendShoppingListItemAddition,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required WatchAppInitializationFlowState watchAppInitializationFlowState,
  }) : _navigator = phoneNavigator,
       _phoneNavigatorUriConfigParserLocator = phoneNavigatorUriConfigParserLocator,
       _uriConfigHolder = uriConfigHolder,
       _uuidGenerator = uuidGenerator,
       _suspendShoppingListItemAddition = suspendShoppingListItemAddition,
       _readAppInitializationFlowState = readAppInitializationFlowState,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _watchAppInitializationFlowState = watchAppInitializationFlowState {
    _navigatorObservers = IList<PhoneNavigatorObserver>([
      ShoppingListItemAdditionSuspensionNavigatorObserver(
        suspendShoppingListItemAddition: _suspendShoppingListItemAddition,
        readShoppingListItemAdditionFlowState: _readShoppingListItemAdditionFlowState,
      ),
      ShoppingListItemAdditionStartNavigatorObserver(
        startShoppingListItemAddition: _startShoppingListItemAddition,
        readShoppingListItemAdditionFlowState: _readShoppingListItemAdditionFlowState,
      ),
    ]);

    final appInitializationFlowStateRef = _readAppInitializationFlowState();

    _syncNavigatorState(
      appInitializationFlowStateRef: appInitializationFlowStateRef,
    );

    _navigatorStateStreamSubscription = _navigator.stateStreamWithPrevious.listen(
      _onNavigatorStateChanged,
    );
  }

  final PhoneNavigator _navigator;
  final PhoneNavigatorUriConfigParserLocator _phoneNavigatorUriConfigParserLocator;
  final UriConfigHolder _uriConfigHolder;
  final UuidGenerator _uuidGenerator;

  final SuspendShoppingListItemAddition _suspendShoppingListItemAddition;
  final ReadAppInitializationFlowState _readAppInitializationFlowState;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final WatchAppInitializationFlowState _watchAppInitializationFlowState;

  late final IList<PhoneNavigatorObserver> _navigatorObservers;

  late final StreamSubscription<ValueWithPrevious<PhoneNavigatorState>>
  _navigatorStateStreamSubscription;

  void _onNavigatorStateChanged(ValueWithPrevious<PhoneNavigatorState> valueWithPrevious) {
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

  PhoneNavigatorStackState _createEmptyStackState() {
    const emptyRoutes = IListConst<AppRoute>([]);

    const emptyRouteToTransition = IMapConst<AppRoute, PhoneRouteTransition>({});

    return const PhoneNavigatorStackState(
      routes: emptyRoutes,
      routeToTransition: emptyRouteToTransition,
    );
  }

  ({IList<AppRoute> routes, IMap<AppRoute, PhoneRouteTransition> routeToTransition})
  _syncNavigatorStack({
    required IList<AppRoute> requiredRoutes,
    required IList<AppRoute> existingRoutes,
    required IMap<AppRoute, PhoneRouteTransition> existingRouteToTransition,
  }) {
    final updatedRoutes = <AppRoute>[];
    final updatedRouteToTransition = existingRouteToTransition.unlock;

    const removalRouteTransition = PhoneRemovalRouteTransition(
      displayTransition: false,
    );

    const additionRouteTransition = PhoneAdditionRouteTransition(
      displayTransition: false,
    );

    var foundDesiredRouteCount = 0;
    var processedExistingRouteCount = 0;

    for (final requiredRoute in requiredRoutes) {
      for (var i = processedExistingRouteCount; i < existingRoutes.length; i++) {
        final existingRoute = existingRoutes[i];

        final existingRouteActive = switch (existingRouteToTransition[existingRoute]) {
          null || PhoneAdditionRouteTransition() => true,
          PhoneRemovalRouteTransition() => false,
        };

        if (!existingRouteActive) {
          updatedRoutes.add(existingRoute);
          processedExistingRouteCount++;
          continue;
        }

        if (requiredRoute.copyWith(id: () => existingRoute.id) == existingRoute) {
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

    for (var i = processedExistingRouteCount; i < existingRoutes.length; i++) {
      final existingRoute = existingRoutes[i];
      updatedRouteToTransition[existingRoute] = removalRouteTransition;
      updatedRoutes.add(existingRoute);
      processedExistingRouteCount++;
    }

    for (var i = foundDesiredRouteCount; i < requiredRoutes.length; i++) {
      final requiredRoute = requiredRoutes[i];
      updatedRoutes.add(requiredRoute);
      updatedRouteToTransition[requiredRoute] = additionRouteTransition;
    }

    return (
      routes: updatedRoutes.lock,
      routeToTransition: updatedRouteToTransition.lock,
    );
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
      final rootRoutes = IList<AppRoute>([
        SplashRoute(
          id: _uuidGenerator.generateUuid(),
        ),
      ]);

      const rootRouteToTransition = IMapConst<AppRoute, PhoneRouteTransition>({});

      final rootStackState = PhoneNavigatorStackState(
        routes: rootRoutes,
        routeToTransition: rootRouteToTransition,
      );

      _navigator.initialize(
        rootStackState: rootStackState,
        homeNavigationState: null,
      );

      return;
    }

    final parser = _phoneNavigatorUriConfigParserLocator.getParserByUriConfig(uriConfig!);

    final requiredRootRoutes = parser.getRequiredRootRoutes();

    final navigatorState = _navigator.initialized ? _navigator.state : null;

    final existingRootStackState = navigatorState?.rootStackState ?? _createEmptyStackState();

    final (
      routes: updatedRootRoutes,
      routeToTransition: updatedRootRouteToTransition,
    ) = _syncNavigatorStack(
      requiredRoutes: requiredRootRoutes,
      existingRoutes: existingRootStackState.routes,
      existingRouteToTransition: existingRootStackState.routeToTransition,
    );

    final updatedRootStackState = existingRootStackState.copyWith(
      routes: () => updatedRootRoutes,
      routeToTransition: () => updatedRootRouteToTransition,
    );

    final homeRouteExists = updatedRootRoutes.any((it) => it is PhoneHomeRoute);

    if (!homeRouteExists) {
      if (_navigator.initialized) {
        _navigator.updateWith(
          rootStackState: () => updatedRootStackState,
          homeNavigationState: () => null,
        );
      } else {
        _navigator.initialize(
          rootStackState: updatedRootStackState,
          homeNavigationState: null,
        );
      }

      return;
    }

    final homeTabStackStateMap = navigatorState?.homeNavigationState?.tabStackStateMap.unlock ?? {};

    final requiredActiveHomeTab = parser.getRequiredActiveHomeTab();

    if (requiredActiveHomeTab != null) {
      final requiredHomeTabRoutes = parser.getRequiredActiveHomeTabRoutes();

      final existingHomeTabStackState =
          homeTabStackStateMap[requiredActiveHomeTab] ?? _createEmptyStackState();

      final (
        routes: updatedHomeTabRoutes,
        routeToTransition: updatedHomeTabRouteToTransition,
      ) = _syncNavigatorStack(
        requiredRoutes: requiredHomeTabRoutes,
        existingRoutes: existingHomeTabStackState.routes,
        existingRouteToTransition: existingHomeTabStackState.routeToTransition,
      );

      final updatedHomeTabStackState = existingHomeTabStackState.copyWith(
        routes: () => updatedHomeTabRoutes,
        routeToTransition: () => updatedHomeTabRouteToTransition,
      );

      homeTabStackStateMap[requiredActiveHomeTab] = updatedHomeTabStackState;
    }

    for (final it in PhoneHomeTab.values) {
      final routes = homeTabStackStateMap[it]?.routes ?? const IListConst<AppRoute>([]);

      if (routes.isNotEmpty) {
        continue;
      }

      final AppRoute route;

      switch (it) {
        case PhoneHomeTab.overview:
          route = PhoneShoppingListOverviewRoute(
            id: _uuidGenerator.generateUuid(),
          );

        case PhoneHomeTab.addition:
          route = PhoneShoppingListItemAdditionRoute(
            id: _uuidGenerator.generateUuid(),
          );
      }

      final updatedRoutes = routes.add(route);
      const emptyRouteToTransition = IMapConst<AppRoute, PhoneRouteTransition>({});

      final stackState = PhoneNavigatorStackState(
        routes: updatedRoutes,
        routeToTransition: emptyRouteToTransition,
      );

      homeTabStackStateMap[it] = stackState;
    }

    if (_navigator.initialized) {
      final homeNavigationState = _navigator.state.homeNavigationState;

      final PhoneHomeNavigationState updatedHomeNavigationState;

      if (homeNavigationState == null) {
        updatedHomeNavigationState = PhoneHomeNavigationState(
          tabStackStateMap: homeTabStackStateMap.lock,
          activeTab: requiredActiveHomeTab ?? PhoneHomeTab.overview,
        );
      } else {
        updatedHomeNavigationState = homeNavigationState.copyWith(
          tabStackStateMap: () => homeTabStackStateMap.lock,
          activeTab: requiredActiveHomeTab == null ? null : () => requiredActiveHomeTab,
        );
      }

      _navigator.updateWith(
        rootStackState: () => updatedRootStackState,
        homeNavigationState: () => updatedHomeNavigationState,
      );
    } else {
      final homeNavigationState = PhoneHomeNavigationState(
        tabStackStateMap: homeTabStackStateMap.lock,
        activeTab: requiredActiveHomeTab ?? PhoneHomeTab.overview,
      );

      _navigator.initialize(
        rootStackState: updatedRootStackState,
        homeNavigationState: homeNavigationState,
      );
    }
  }

  @override
  void onRouteAddedToRootNavigator({
    required AppRoute route,
  }) {
    final updatedRootRouteToTransition = _navigator.state.rootStackState.routeToTransition.remove(
      route,
    );

    final updatedRootStackState = _navigator.state.rootStackState.copyWith(
      routeToTransition: () => updatedRootRouteToTransition,
    );

    _navigator.updateWith(
      rootStackState: () => updatedRootStackState,
    );
  }

  @override
  void onRouteRemovedFromRootNavigator({
    required AppRoute route,
  }) {
    final updatedRootRoutes = _navigator.state.rootStackState.routes.remove(route);

    final updatedRootRouteToTransition = _navigator.state.rootStackState.routeToTransition.remove(
      route,
    );

    final updatedRootStackState = _navigator.state.rootStackState.copyWith(
      routes: () => updatedRootRoutes,
      routeToTransition: () => updatedRootRouteToTransition,
    );

    _navigator.updateWith(
      rootStackState: () => updatedRootStackState,
    );
  }

  @override
  void onRootRoutePopped({
    required AppRoute route,
  }) {
    final stackState = _navigator.state.rootStackState;

    if (!stackState.routes.contains(route)) {
      return;
    }

    final transition = stackState.routeToTransition[route];

    if (transition is PhoneRemovalRouteTransition) {
      return;
    }

    const updatedTransition = PhoneRemovalRouteTransition(
      displayTransition: false,
    );

    final updatedRouteToTransition = stackState.routeToTransition.add(
      route,
      updatedTransition,
    );

    final updatedStackState = stackState.copyWith(
      routeToTransition: () => updatedRouteToTransition,
    );

    _navigator.updateWith(
      rootStackState: () => updatedStackState,
    );
  }

  @override
  void onHomeTabRoutePopped({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  }) {
    final homeNavigationState = _navigator.state.homeNavigationState!;

    final stackState = homeNavigationState.tabStackStateMap[homeTab]!;

    if (!stackState.routes.contains(route)) {
      return;
    }

    final transition = stackState.routeToTransition[route];

    if (transition is PhoneRemovalRouteTransition) {
      return;
    }

    const updatedTransition = PhoneRemovalRouteTransition(
      displayTransition: false,
    );

    final updatedRouteToTransition = stackState.routeToTransition.add(
      route,
      updatedTransition,
    );

    final updatedStackState = stackState.copyWith(
      routeToTransition: () => updatedRouteToTransition,
    );

    final updatedHomeTabStackStateMap = homeNavigationState.tabStackStateMap.add(
      homeTab,
      updatedStackState,
    );

    final updatedHomeNavigationState = homeNavigationState.copyWith(
      tabStackStateMap: () => updatedHomeTabStackStateMap,
    );

    _navigator.updateWith(
      homeNavigationState: () => updatedHomeNavigationState,
    );
  }

  @override
  void onRouteAddedToHomeTabNavigator({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  }) {
    final homeNavigationState = _navigator.state.homeNavigationState!;

    final stackState = homeNavigationState.tabStackStateMap[homeTab]!;

    final updatedRouteToTransition = stackState.routeToTransition.remove(route);

    final updatedStackState = stackState.copyWith(
      routeToTransition: () => updatedRouteToTransition,
    );

    final updatedHomeTabStackStateMap = homeNavigationState.tabStackStateMap.add(
      homeTab,
      updatedStackState,
    );

    final updatedHomeNavigationState = homeNavigationState.copyWith(
      tabStackStateMap: () => updatedHomeTabStackStateMap,
    );

    _navigator.updateWith(
      homeNavigationState: () => updatedHomeNavigationState,
    );
  }

  @override
  void onRouteRemovedFromHomeTabNavigator({
    required AppRoute route,
    required PhoneHomeTab homeTab,
  }) {
    final homeNavigationState = _navigator.state.homeNavigationState!;

    final stackState = homeNavigationState.tabStackStateMap[homeTab]!;

    final updatedRoutes = stackState.routes.remove(route);
    final updatedRouteToTransition = stackState.routeToTransition.remove(route);

    final updatedStackState = stackState.copyWith(
      routes: () => updatedRoutes,
      routeToTransition: () => updatedRouteToTransition,
    );

    final updatedHomeTabStackStateMap = homeNavigationState.tabStackStateMap.add(
      homeTab,
      updatedStackState,
    );

    final updatedHomeNavigationState = homeNavigationState.copyWith(
      tabStackStateMap: () => updatedHomeTabStackStateMap,
    );

    _navigator.updateWith(
      homeNavigationState: () => updatedHomeNavigationState,
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

    final activeRootRoutes = _filterActiveRoutes(
      routes: _navigator.state.rootStackState.routes,
      routeToTransition: _navigator.state.rootStackState.routeToTransition,
    );

    final activeHomeTab = _navigator.state.homeNavigationState?.activeTab;

    IList<AppRoute>? activeHomeTabActiveRoutes;

    if (activeHomeTab != null) {
      final stackState = _navigator.state.homeNavigationState!.tabStackStateMap[activeHomeTab]!;

      activeHomeTabActiveRoutes = _filterActiveRoutes(
        routes: stackState.routes,
        routeToTransition: stackState.routeToTransition,
      );
    }

    final parsers = _phoneNavigatorUriConfigParserLocator.getAllParsers();

    PhoneNavigatorUriConfigMatchResult? bestMatchResult;

    for (final parser in parsers) {
      PhoneNavigatorUriConfigMatchResult? matchResult;

      switch (parser) {
        case ShoppingListOverviewUriConfigParser():
          if (activeHomeTab != null && activeHomeTabActiveRoutes != null) {
            matchResult = parser.tryParse(
              activeRootRoutes: activeRootRoutes,
              activeHomeTab: activeHomeTab,
              activeHomeTabActiveRoutes: activeHomeTabActiveRoutes,
            );
          }

        case ShoppingListItemAdditionUriConfigParser():
          if (activeHomeTab != null && activeHomeTabActiveRoutes != null) {
            matchResult = parser.tryParse(
              activeRootRoutes: activeRootRoutes,
              activeHomeTab: activeHomeTab,
              activeHomeTabActiveRoutes: activeHomeTabActiveRoutes,
            );
          }
      }

      if (matchResult == null) {
        continue;
      }

      if (bestMatchResult == null) {
        bestMatchResult = matchResult;
        continue;
      }

      if (matchResult.matchedRequiredRootRouteCount <
          bestMatchResult.matchedRequiredRootRouteCount) {
        continue;
      }

      if (matchResult.matchedRequiredRootRouteCount >
          bestMatchResult.matchedRequiredRootRouteCount) {
        bestMatchResult = matchResult;
        continue;
      }

      if (matchResult.matchedRequiredHomeTabRouteCount <
          bestMatchResult.matchedRequiredHomeTabRouteCount) {
        continue;
      }

      if (matchResult.matchedRequiredHomeTabRouteCount >
          bestMatchResult.matchedRequiredHomeTabRouteCount) {
        bestMatchResult = matchResult;
        continue;
      }

      if (matchResult.matchedRequiredFlowStateCount >
          bestMatchResult.matchedRequiredFlowStateCount) {
        bestMatchResult = matchResult;
        continue;
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

    final appInitializationFlowStateRef = _readAppInitializationFlowState();

    if (appInitializationFlowStateRef is! LoadedAppInitializationFlowStateRef) {
      await _watchAppInitializationFlowState().firstWhere((appInitializationFlowStateRef) {
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
    _navigatorStateStreamSubscription.cancel();
  }
}
