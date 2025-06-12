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
import '../shared/uri_config_holder.dart';
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
    required UriConfigHolder uriConfigHolder,
    required UuidGenerator uuidGenerator,
    required ReadAppInitializationFlowState readAppInitializationFlowState,
    required ReadShoppingListItemAdditionFlowState readShoppingListItemAdditionFlowState,
    required StartShoppingListItemAddition startShoppingListItemAddition,
    required WatchAppInitializationFlowState watchAppInitializationFlowState,
  }) : _desktopNavigator = desktopNavigator,
       _desktopNavigatorUriConfigParserLocator = desktopNavigatorUriConfigParserLocator,
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

  final DesktopNavigator _desktopNavigator;
  final DesktopNavigatorUriConfigParserLocator _desktopNavigatorUriConfigParserLocator;
  final UriConfigHolder _uriConfigHolder;
  final UuidGenerator _uuidGenerator;

  final ReadAppInitializationFlowState _readAppInitializationFlowState;
  final ReadShoppingListItemAdditionFlowState _readShoppingListItemAdditionFlowState;
  final StartShoppingListItemAddition _startShoppingListItemAddition;
  final WatchAppInitializationFlowState _watchAppInitializationFlowState;

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

  void _syncNavigatorState({
    required AppInitializationFlowStateRef appInitializationFlowStateRef,
  }) {
    final uriConfig = _uriConfigHolder.lastKnownUriConfig;

    final shouldInitWithSplashScreen = switch (appInitializationFlowStateRef) {
      InitialAppInitializationFlowStateRef() ||
      LoadingAppInitializationFlowStateRef() => !_desktopNavigator.initialized,
      LoadedAppInitializationFlowStateRef() => !_desktopNavigator.initialized && uriConfig == null,
    };

    if (shouldInitWithSplashScreen) {
      final routes = IList<AppRoute>([
        SplashRoute(
          id: _uuidGenerator.generateUuid(),
        ),
      ]);

      const routeToTransition = IMapConst<AppRoute, DesktopRouteTransition>({});

      _desktopNavigator.initialize(
        routes: routes,
        routeToTransition: routeToTransition,
      );

      return;
    }

    final parser = _desktopNavigatorUriConfigParserLocator.getParserByUriConfig(
      uriConfig!,
    );

    final requiredRoutes = parser.getRequiredRoutes();

    final navigatorState = _desktopNavigator.initialized ? _desktopNavigator.state : null;

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

        if (requiredRoute.copyWith(id: () => existingRoute.id) == existingRoute) {
          updatedRouteToTransition[existingRoute] = additionRouteTransition;
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

    for (var i = foundRequiredRouteCount; i < requiredRoutes.length; i++) {
      final requiredRoute = requiredRoutes[i];
      updatedRoutes.add(requiredRoute);
      updatedRouteToTransition[requiredRoute] = additionRouteTransition;
    }

    if (_desktopNavigator.initialized) {
      _desktopNavigator.updateWith(
        routes: () => updatedRoutes.lock,
        routeToTransition: () => updatedRouteToTransition.lock,
      );
    } else {
      _desktopNavigator.initialize(
        routes: updatedRoutes.lock,
        routeToTransition: updatedRouteToTransition.lock,
      );
    }
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
    final appInitializationFlowStateRef = _readAppInitializationFlowState();

    switch (appInitializationFlowStateRef) {
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
}
