import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/stream/disposable.dart';
import '../../../../../core/common/stream/state_streamable.dart';
import '../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_app_routes.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_home_tab.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_navigator.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../../../../features/shopping_list/application/use_cases/cancel_shopping_list_item_addition.dart';
import '../../../../../features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../features/shopping_list/application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../application/refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../../../../application/use_cases/read_app_initialization_flow_state.dart';
import '../../../../application/use_cases/watch_app_initialization_flow_state.dart';
import '../shared/uri_config_holder.dart';
import '../shared/uri_configs.dart';
import 'mobile_navigator_observers.dart';
import 'mobile_navigator_uri_config_parser_locator.dart';
import 'mobile_navigator_uri_config_parsers.dart';

abstract interface class MobileNavigatorPresenter
    implements AsyncStateStreamable<MobileNavigatorState>, Disposable {
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
    required MobileHomeTab homeTab,
  });

  void onRouteRemovedFromHomeTabNavigator({
    required AppRoute route,
    required MobileHomeTab homeTab,
  });

  void onHomeTabRoutePopped({
    required AppRoute route,
    required MobileHomeTab homeTab,
  });

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUserConfig();
}

@LazySingleton(as: MobileNavigatorPresenter)
class MobileNavigatorPresenterImpl implements MobileNavigatorPresenter {
  MobileNavigatorPresenterImpl({
    required MobileNavigator mobileNavigator,
    required MobileNavigatorUriConfigParserLocator mobileNavigatorUriConfigParserLocator,
    required UriConfigHolder uriConfigHolder,
    required UuidGenerator uuidGenerator,
    required CancelShoppingListItemAddition cancelShoppingListItemAddition,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required WatchAppInitializationFlowState watchAppInitializationFlowState,
  }) : _navigator = mobileNavigator,
       _mobileNavigatorUriConfigParserLocator = mobileNavigatorUriConfigParserLocator,
       _uriConfigHolder = uriConfigHolder,
       _uuidGenerator = uuidGenerator,
       _cancelShoppingListItemAddition = cancelShoppingListItemAddition,
       _readAppInitializationFlowState = readAppInitializationFlowState,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _watchAppInitializationFlowState = watchAppInitializationFlowState {
    _navigatorObservers = IList<MobileNavigatorObserver>([
      ShoppingListItemAdditionCancellationNavigatorObserver(
        cancelShoppingListItemAddition: _cancelShoppingListItemAddition,
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

  final MobileNavigator _navigator;
  final MobileNavigatorUriConfigParserLocator _mobileNavigatorUriConfigParserLocator;
  final UriConfigHolder _uriConfigHolder;
  final UuidGenerator _uuidGenerator;

  final CancelShoppingListItemAddition _cancelShoppingListItemAddition;
  final ReadAppInitializationFlowState _readAppInitializationFlowState;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final WatchAppInitializationFlowState _watchAppInitializationFlowState;

  late final IList<MobileNavigatorObserver> _navigatorObservers;

  late final StreamSubscription<ValueWithPrevious<MobileNavigatorState>>
  _navigatorStateStreamSubscription;

  @override
  MobileNavigatorState get state => _navigator.state;

  @override
  Stream<MobileNavigatorState> get stateStream => _navigator.stateStream;

  void _onNavigatorStateChanged(ValueWithPrevious<MobileNavigatorState> valueWithPrevious) {
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
    required IMap<AppRoute, MobileRouteTransition> routeToTransition,
  }) {
    return routes.where((route) {
      final transition = routeToTransition[route];

      switch (transition) {
        case null:
        case MobileAdditionRouteTransition():
          return true;

        case MobileRemovalRouteTransition():
          return false;
      }
    }).toIList();
  }

  MobileNavigatorStackState _createEmptyStackState() {
    const emptyRoutes = IListConst<AppRoute>([]);

    const emptyRouteToTransition = IMapConst<AppRoute, MobileRouteTransition>({});

    return const MobileNavigatorStackState(
      routes: emptyRoutes,
      routeToTransition: emptyRouteToTransition,
    );
  }

  ({IList<AppRoute> routes, IMap<AppRoute, MobileRouteTransition> routeToTransition})
  _syncNavigatorStack({
    required IList<AppRoute> requiredRoutes,
    required IList<AppRoute> existingRoutes,
    required IMap<AppRoute, MobileRouteTransition> existingRouteToTransition,
  }) {
    final updatedRoutes = <AppRoute>[];
    final updatedRouteToTransition = existingRouteToTransition.unlock;

    const removalRouteTransition = MobileRemovalRouteTransition(
      displayTransition: false,
    );

    const additionRouteTransition = MobileAdditionRouteTransition(
      displayTransition: false,
    );

    var foundDesiredRouteCount = 0;
    var processedExistingRouteCount = 0;

    for (final requiredRoute in requiredRoutes) {
      for (var i = processedExistingRouteCount; i < existingRoutes.length; i++) {
        final existingRoute = existingRoutes[i];

        final existingRouteActive = switch (existingRouteToTransition[existingRoute]) {
          null || MobileAdditionRouteTransition() => true,
          MobileRemovalRouteTransition() => false,
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

      const rootRouteToTransition = IMapConst<AppRoute, MobileRouteTransition>({});

      final rootStackState = MobileNavigatorStackState(
        routes: rootRoutes,
        routeToTransition: rootRouteToTransition,
      );

      _navigator.initialize(
        rootStackState: rootStackState,
        homeNavigationState: null,
      );

      return;
    }

    final parser = _mobileNavigatorUriConfigParserLocator.getParserByUriConfig(uriConfig!);

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

    final homeRouteExists = updatedRootRoutes.any((it) => it is MobileHomeRoute);

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

    for (final it in MobileHomeTab.values) {
      final routes = homeTabStackStateMap[it]?.routes ?? const IListConst<AppRoute>([]);

      if (routes.isNotEmpty) {
        continue;
      }

      final AppRoute route;

      switch (it) {
        case MobileHomeTab.overview:
          route = MobileShoppingListOverviewRoute(
            id: _uuidGenerator.generateUuid(),
          );

        case MobileHomeTab.addition:
          route = MobileShoppingListItemAdditionRoute(
            id: _uuidGenerator.generateUuid(),
          );
      }

      final updatedRoutes = routes.add(route);
      const emptyRouteToTransition = IMapConst<AppRoute, MobileRouteTransition>({});

      final stackState = MobileNavigatorStackState(
        routes: updatedRoutes,
        routeToTransition: emptyRouteToTransition,
      );

      homeTabStackStateMap[it] = stackState;
    }

    if (_navigator.initialized) {
      final homeNavigationState = _navigator.state.homeNavigationState;

      final MobileHomeNavigationState updatedHomeNavigationState;

      if (homeNavigationState == null) {
        updatedHomeNavigationState = MobileHomeNavigationState(
          tabStackStateMap: homeTabStackStateMap.lock,
          activeTab: requiredActiveHomeTab ?? MobileHomeTab.overview,
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
      final homeNavigationState = MobileHomeNavigationState(
        tabStackStateMap: homeTabStackStateMap.lock,
        activeTab: requiredActiveHomeTab ?? MobileHomeTab.overview,
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

    if (transition is MobileRemovalRouteTransition) {
      return;
    }

    const updatedTransition = MobileRemovalRouteTransition(
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
    required MobileHomeTab homeTab,
  }) {
    final homeNavigationState = _navigator.state.homeNavigationState!;

    final stackState = homeNavigationState.tabStackStateMap[homeTab]!;

    if (!stackState.routes.contains(route)) {
      return;
    }

    final transition = stackState.routeToTransition[route];

    if (transition is MobileRemovalRouteTransition) {
      return;
    }

    const updatedTransition = MobileRemovalRouteTransition(
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
    required MobileHomeTab homeTab,
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
    required MobileHomeTab homeTab,
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

    final parsers = _mobileNavigatorUriConfigParserLocator.getAllParsers();

    MobileNavigatorUriConfigMatchResult? bestMatchResult;

    for (final parser in parsers) {
      MobileNavigatorUriConfigMatchResult? matchResult;

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
