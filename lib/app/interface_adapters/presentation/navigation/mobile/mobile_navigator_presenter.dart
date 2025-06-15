import 'dart:async';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../core/common/stream/state_streamable.dart';
import '../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../features/home/interface_adapters/presentation/mobile_home_tab.dart';
import '../../../../../features/shopping_list/application/use_cases/read_shopping_list_item_addition_flow_state.dart';
import '../../../../../features/shopping_list/application/use_cases/start_shopping_list_item_addition.dart';
import '../../../../application/refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../../../../application/use_cases/read_app_initialization_flow_state.dart';
import '../../../../application/use_cases/watch_app_initialization_flow_state.dart';
import '../shared/app_routes.dart';
import '../shared/uri_config_holder.dart';
import '../shared/uri_configs.dart';
import 'mobile_navigator.dart';
import 'mobile_navigator_uri_config_parser_locator.dart';
import 'mobile_navigator_uri_config_parsers.dart';

abstract interface class MobileNavigatorPresenter
    implements AsyncStateStreamable<MobileNavigatorState> {
  void onRouteAddedToRootNavigator({
    required AppRoute route,
  });

  void onRouteRemovedFromRootNavigator({
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

  void onPlatformUriConfigChanged(UriConfig uriConfig);

  UriConfig? getCurrentUserConfig();
}

class MobileNavigatorPresenterImpl implements MobileNavigatorPresenter {
  MobileNavigatorPresenterImpl({
    required MobileNavigator mobileNavigator,
    required MobileNavigatorUriConfigParserLocator mobileNavigatorUriConfigParserLocator,
    required UriConfigHolder uriConfigHolder,
    required UuidGenerator uuidGenerator,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required WatchAppInitializationFlowState watchAppInitializationFlowState,
  }) : _mobileNavigator = mobileNavigator,
       _mobileNavigatorUriConfigParserLocator = mobileNavigatorUriConfigParserLocator,
       _uriConfigHolder = uriConfigHolder,
       _uuidGenerator = uuidGenerator,
       _readAppInitializationFlowState = readAppInitializationFlowState,
       _readShoppingListItemAdditionFlowState = readShoppingListItemAdditionFlowState,
       _startShoppingListItemAddition = startShoppingListItemAddition,
       _watchAppInitializationFlowState = watchAppInitializationFlowState {
    final appInitializationFlowStateRef = _readAppInitializationFlowState();

    _syncNavigatorState(
      appInitializationFlowStateRef: appInitializationFlowStateRef,
    );
  }

  final MobileNavigator _mobileNavigator;
  final MobileNavigatorUriConfigParserLocator _mobileNavigatorUriConfigParserLocator;
  final UriConfigHolder _uriConfigHolder;
  final UuidGenerator _uuidGenerator;

  final ReadAppInitializationFlowState _readAppInitializationFlowState;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final WatchAppInitializationFlowState _watchAppInitializationFlowState;

  @override
  MobileNavigatorState get state => _mobileNavigator.state;

  @override
  Stream<MobileNavigatorState> get stateStream => _mobileNavigator.stateStream;

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
      LoadingAppInitializationFlowStateRef() => !_mobileNavigator.initialized,
      LoadedAppInitializationFlowStateRef() => !_mobileNavigator.initialized && uriConfig == null,
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

      final homeTabStackStateMap = IMap.fromEntries(
        MobileHomeTab.values.map((tab) {
          return MapEntry(tab, _createEmptyStackState());
        }),
      );

      _mobileNavigator.initialize(
        rootStackState: rootStackState,
        homeTabStackStateMap: homeTabStackStateMap,
        activeHomeTab: null,
      );

      return;
    }

    final parser = _mobileNavigatorUriConfigParserLocator.getParserByUriConfig(uriConfig!);

    final requiredRootRoutes = parser.getRequiredRootRoutes();

    final navigatorState = _mobileNavigator.initialized ? _mobileNavigator.state : null;

    final existingRootStackState = navigatorState?.rootStackState ?? _createEmptyStackState();

    final (
      routes: updatedRootRoutes,
      routeToTransition: updatedRootRouteToTransition,
    ) = _syncNavigatorStack(
      requiredRoutes: requiredRootRoutes,
      existingRoutes: existingRootStackState.routes,
      existingRouteToTransition: existingRootStackState.routeToTransition,
    );

    final homeTab = parser.getHomeTab();
    final requiredHomeTabRoutes = parser.getRequiredHomeTabRoutes();

    final existingHomeTabStackState =
        navigatorState?.homeTabStackStateMap[homeTab] ?? _createEmptyStackState();

    final (
      routes: updatedHomeTabRoutes,
      routeToTransition: updatedHomeTabRouteToTransition,
    ) = _syncNavigatorStack(
      requiredRoutes: requiredHomeTabRoutes,
      existingRoutes: existingHomeTabStackState.routes,
      existingRouteToTransition: existingHomeTabStackState.routeToTransition,
    );

    final updatedRootStackState = existingRootStackState.copyWith(
      routes: () => updatedRootRoutes,
      routeToTransition: () => updatedRootRouteToTransition,
    );

    final updatedHomeTabStackState = existingHomeTabStackState.copyWith(
      routes: () => updatedHomeTabRoutes,
      routeToTransition: () => updatedHomeTabRouteToTransition,
    );

    if (_mobileNavigator.initialized) {
      final updatedHomeTabStackStateMap = _mobileNavigator.state.homeTabStackStateMap.add(
        homeTab,
        updatedHomeTabStackState,
      );

      _mobileNavigator.updateWith(
        rootStackState: () => updatedRootStackState,
        homeTabStackStateMap: () => updatedHomeTabStackStateMap,
        activeHomeTab: () => homeTab,
      );
    } else {
      final homeTabStackStateMap = IMap.fromEntries(
        MobileHomeTab.values.map((it) {
          if (it == homeTab) {
            return MapEntry(it, updatedHomeTabStackState);
          }

          return MapEntry(it, _createEmptyStackState());
        }),
      );

      _mobileNavigator.initialize(
        rootStackState: updatedRootStackState,
        homeTabStackStateMap: homeTabStackStateMap,
        activeHomeTab: homeTab,
      );
    }
  }

  @override
  void onRouteAddedToRootNavigator({
    required AppRoute route,
  }) {
    final updatedRootRouteToTransition = _mobileNavigator.state.rootStackState.routeToTransition
        .remove(route);

    final updatedRootStackState = _mobileNavigator.state.rootStackState.copyWith(
      routeToTransition: () => updatedRootRouteToTransition,
    );

    _mobileNavigator.updateWith(
      rootStackState: () => updatedRootStackState,
    );
  }

  @override
  void onRouteRemovedFromRootNavigator({
    required AppRoute route,
  }) {
    final updatedRootRoutes = _mobileNavigator.state.rootStackState.routes.remove(route);

    final updatedRootRouteToTransition = _mobileNavigator.state.rootStackState.routeToTransition
        .remove(route);

    final updatedRootStackState = _mobileNavigator.state.rootStackState.copyWith(
      routes: () => updatedRootRoutes,
      routeToTransition: () => updatedRootRouteToTransition,
    );

    _mobileNavigator.updateWith(
      rootStackState: () => updatedRootStackState,
    );
  }

  @override
  void onRouteAddedToHomeTabNavigator({
    required AppRoute route,
    required MobileHomeTab homeTab,
  }) {
    final stackState = _mobileNavigator.state.homeTabStackStateMap[homeTab]!;

    final updatedRouteToTransition = stackState.routeToTransition.remove(route);

    final updatedStackState = stackState.copyWith(
      routeToTransition: () => updatedRouteToTransition,
    );

    final updatedHomeTabStackStateMap = _mobileNavigator.state.homeTabStackStateMap.add(
      homeTab,
      updatedStackState,
    );

    _mobileNavigator.updateWith(
      homeTabStackStateMap: () => updatedHomeTabStackStateMap,
    );
  }

  @override
  void onRouteRemovedFromHomeTabNavigator({
    required AppRoute route,
    required MobileHomeTab homeTab,
  }) {
    final stackState = _mobileNavigator.state.homeTabStackStateMap[homeTab]!;

    final updatedRoutes = stackState.routes.remove(route);
    final updatedRouteToTransition = stackState.routeToTransition.remove(route);

    final updatedStackState = stackState.copyWith(
      routes: () => updatedRoutes,
      routeToTransition: () => updatedRouteToTransition,
    );

    final updatedHomeTabStackStateMap = _mobileNavigator.state.homeTabStackStateMap.add(
      homeTab,
      updatedStackState,
    );

    _mobileNavigator.updateWith(
      homeTabStackStateMap: () => updatedHomeTabStackStateMap,
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
      routes: _mobileNavigator.state.rootStackState.routes,
      routeToTransition: _mobileNavigator.state.rootStackState.routeToTransition,
    );

    final activeHomeTab = _mobileNavigator.state.activeHomeTab;

    IList<AppRoute>? activeHomeTabActiveRoutes;

    if (activeHomeTab != null) {
      final stackState = _mobileNavigator.state.homeTabStackStateMap[activeHomeTab]!;

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
          final shoppingListItemAdditionFlowStateRef = _readShoppingListItemAdditionFlowState();

          if (activeHomeTab != null && activeHomeTabActiveRoutes != null) {
            matchResult = parser.tryParse(
              activeRootRoutes: activeRootRoutes,
              activeHomeTab: activeHomeTab,
              activeHomeTabActiveRoutes: activeHomeTabActiveRoutes,
              shoppingListItemAdditionFlowStateRef: shoppingListItemAdditionFlowStateRef,
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
}
