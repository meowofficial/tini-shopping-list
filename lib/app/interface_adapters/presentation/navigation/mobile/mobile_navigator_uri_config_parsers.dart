import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import '../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../features/home/interface_adapters/presentation/mobile_home_tab.dart';
import '../../../../../features/shopping_list/application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../mobile/mobile_app_routes.dart';
import '../shared/uri_configs.dart';

class MobileNavigatorUriConfigMatchResult<T extends UriConfig> extends Equatable {
  const MobileNavigatorUriConfigMatchResult({
    required this.uriConfig,
    required this.matchedRequiredRootRouteCount,
    required this.matchedRequiredHomeTabRouteCount,
    required this.matchedRequiredFlowStateCount,
  });

  final T uriConfig;
  final int matchedRequiredRootRouteCount;
  final int matchedRequiredHomeTabRouteCount;
  final int matchedRequiredFlowStateCount;

  @override
  List<Object?> get props {
    return [
      uriConfig,
      matchedRequiredRootRouteCount,
      matchedRequiredHomeTabRouteCount,
      matchedRequiredFlowStateCount,
    ];
  }
}

sealed class MobileNavigatorUriConfigParser<T extends UriConfig> {
  IList<AppRoute> getRequiredRootRoutes();

  IList<AppRoute> getRequiredHomeTabRoutes();

  MobileHomeTab getHomeTab();
}

abstract class _BaseMobileNavigatorUriConfigParser<T extends UriConfig> {
  const _BaseMobileNavigatorUriConfigParser();

  @protected
  int getMatchedRequiredRouteCount({
    required IList<AppRoute> activeRoutes,
    required IList<AppRoute> requiredRoutes,
  }) {
    var matchedRequiredRouteCount = 0;
    var processedActiveRouteCount = 0;

    for (final requiredRoute in requiredRoutes) {
      for (var i = processedActiveRouteCount; i < activeRoutes.length; i++) {
        final activeRoute = activeRoutes[i];

        if (requiredRoute.copyWith(id: () => activeRoute.id) == activeRoute) {
          matchedRequiredRouteCount++;
          processedActiveRouteCount++;
          break;
        }

        processedActiveRouteCount++;
      }

      if (processedActiveRouteCount == activeRoutes.length) {
        break;
      }
    }

    return matchedRequiredRouteCount;
  }
}

class ShoppingListOverviewUriConfigParser
    extends _BaseMobileNavigatorUriConfigParser<ShoppingListOverviewUriConfig>
    implements MobileNavigatorUriConfigParser<ShoppingListOverviewUriConfig> {
  const ShoppingListOverviewUriConfigParser({
    required UuidGenerator uuidGenerator,
  }) : _uuidGenerator = uuidGenerator;

  final UuidGenerator _uuidGenerator;

  MobileNavigatorUriConfigMatchResult<ShoppingListOverviewUriConfig>? tryParse({
    required IList<AppRoute> activeRootRoutes,
    required IList<AppRoute> activeHomeTabActiveRoutes,
    required MobileHomeTab activeHomeTab,
  }) {
    if (activeHomeTab != getHomeTab()) {
      return null;
    }

    final requiredRootRoutes = getRequiredRootRoutes();

    final matchedRootRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeRootRoutes,
      requiredRoutes: requiredRootRoutes,
    );

    if (matchedRootRouteCount != requiredRootRoutes.length) {
      return null;
    }

    final requiredHomeTabRoutes = getRequiredHomeTabRoutes();

    final matchedHomeTabRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeHomeTabActiveRoutes,
      requiredRoutes: requiredHomeTabRoutes,
    );

    if (matchedHomeTabRouteCount != requiredHomeTabRoutes.length) {
      return null;
    }

    const uriConfig = ShoppingListOverviewUriConfig();

    return MobileNavigatorUriConfigMatchResult(
      uriConfig: uriConfig,
      matchedRequiredRootRouteCount: matchedRootRouteCount,
      matchedRequiredHomeTabRouteCount: matchedHomeTabRouteCount,
      matchedRequiredFlowStateCount: 0,
    );
  }

  @override
  IList<AppRoute> getRequiredRootRoutes() {
    return IList<AppRoute>([
      MobileHomeRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  IList<AppRoute> getRequiredHomeTabRoutes() {
    return IList<AppRoute>([
      MobileShoppingListOverviewRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  MobileHomeTab getHomeTab() {
    return MobileHomeTab.overview;
  }
}

class ShoppingListItemAdditionUriConfigParser
    extends _BaseMobileNavigatorUriConfigParser<ShoppingListItemAdditionUriConfig>
    implements MobileNavigatorUriConfigParser<ShoppingListItemAdditionUriConfig> {
  const ShoppingListItemAdditionUriConfigParser({
    required UuidGenerator uuidGenerator,
  }) : _uuidGenerator = uuidGenerator;

  final UuidGenerator _uuidGenerator;

  MobileNavigatorUriConfigMatchResult<ShoppingListItemAdditionUriConfig>? tryParse({
    required IList<AppRoute> activeRootRoutes,
    required IList<AppRoute> activeHomeTabActiveRoutes,
    required MobileHomeTab activeHomeTab,
    required ShoppingListItemAdditionFlowStateRef shoppingListItemAdditionFlowStateRef,
  }) {
    switch (shoppingListItemAdditionFlowStateRef) {
      case IdleShoppingListItemAdditionFlowStateRef():
        return null;

      case OngoingShoppingListItemAdditionFlowStateRef():
        break;
    }

    if (activeHomeTab != getHomeTab()) {
      return null;
    }

    final requiredRootRoutes = getRequiredRootRoutes();

    final matchedRootRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeRootRoutes,
      requiredRoutes: requiredRootRoutes,
    );

    if (matchedRootRouteCount != requiredRootRoutes.length) {
      return null;
    }

    final requiredHomeTabRoutes = getRequiredHomeTabRoutes();

    final matchedHomeTabRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeHomeTabActiveRoutes,
      requiredRoutes: requiredHomeTabRoutes,
    );

    if (matchedHomeTabRouteCount != requiredHomeTabRoutes.length) {
      return null;
    }

    const uriConfig = ShoppingListItemAdditionUriConfig();

    return MobileNavigatorUriConfigMatchResult(
      uriConfig: uriConfig,
      matchedRequiredRootRouteCount: matchedRootRouteCount,
      matchedRequiredHomeTabRouteCount: matchedHomeTabRouteCount,
      matchedRequiredFlowStateCount: 1,
    );
  }

  @override
  IList<AppRoute> getRequiredRootRoutes() {
    return IList<AppRoute>([
      MobileHomeRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  IList<AppRoute> getRequiredHomeTabRoutes() {
    return IList<AppRoute>([
      MobileShoppingListItemAdditionRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  MobileHomeTab getHomeTab() {
    return MobileHomeTab.addition;
  }
}
