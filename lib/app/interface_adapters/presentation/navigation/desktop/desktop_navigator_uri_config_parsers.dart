import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import '../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../features/shopping_list/application/refs/flow_state_refs/shopping_list_item_addition_flow_state_ref.dart';
import '../shared/uri_configs.dart';
import 'desktop_app_routes.dart';

class DesktopNavigatorUriConfigMatchResult<T extends UriConfig> extends Equatable {
  const DesktopNavigatorUriConfigMatchResult({
    required this.uriConfig,
    required this.matchedRequiredRouteCount,
    required this.matchedRequiredFlowStateCount,
  });

  final T uriConfig;
  final int matchedRequiredRouteCount;
  final int matchedRequiredFlowStateCount;

  @override
  List<Object?> get props {
    return [
      uriConfig,
      matchedRequiredRouteCount,
      matchedRequiredFlowStateCount,
    ];
  }
}

sealed class DesktopNavigatorUriConfigParser<T extends UriConfig> {
  IList<AppRoute> getRequiredRoutes();
}

abstract class _BaseDesktopNavigatorUriConfigParser<T extends UriConfig> {
  const _BaseDesktopNavigatorUriConfigParser();

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
    extends _BaseDesktopNavigatorUriConfigParser<ShoppingListOverviewUriConfig>
    implements DesktopNavigatorUriConfigParser<ShoppingListOverviewUriConfig> {
  const ShoppingListOverviewUriConfigParser({
    required UuidGenerator uuidGenerator,
  }) : _uuidGenerator = uuidGenerator;

  final UuidGenerator _uuidGenerator;

  DesktopNavigatorUriConfigMatchResult<ShoppingListOverviewUriConfig>? tryParse({
    required IList<AppRoute> activeRoutes,
  }) {
    final requiredRoutes = getRequiredRoutes();

    final matchedRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeRoutes,
      requiredRoutes: requiredRoutes,
    );

    if (matchedRouteCount != requiredRoutes.length) {
      return null;
    }

    const uriConfig = ShoppingListOverviewUriConfig();

    return DesktopNavigatorUriConfigMatchResult(
      uriConfig: uriConfig,
      matchedRequiredRouteCount: matchedRouteCount,
      matchedRequiredFlowStateCount: 0,
    );
  }

  @override
  IList<AppRoute> getRequiredRoutes() {
    return IList<AppRoute>([
      DesktopShoppingListOverviewRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }
}

class ShoppingListItemAdditionUriConfigParser
    extends _BaseDesktopNavigatorUriConfigParser<ShoppingListItemAdditionUriConfig>
    implements DesktopNavigatorUriConfigParser<ShoppingListItemAdditionUriConfig> {
  const ShoppingListItemAdditionUriConfigParser({
    required UuidGenerator uuidGenerator,
  }) : _uuidGenerator = uuidGenerator;

  final UuidGenerator _uuidGenerator;

  DesktopNavigatorUriConfigMatchResult<ShoppingListItemAdditionUriConfig>? tryParse({
    required IList<AppRoute> activeRoutes,
    required ShoppingListItemAdditionFlowStateRef shoppingListItemAdditionFlowStateRef,
  }) {
    switch (shoppingListItemAdditionFlowStateRef) {
      case IdleShoppingListItemAdditionFlowStateRef():
        return null;

      case OngoingShoppingListItemAdditionFlowStateRef():
        break;
    }

    final requiredRoutes = getRequiredRoutes();

    final matchedRequiredRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeRoutes,
      requiredRoutes: requiredRoutes,
    );

    if (matchedRequiredRouteCount != requiredRoutes.length) {
      return null;
    }

    const uriConfig = ShoppingListItemAdditionUriConfig();

    return DesktopNavigatorUriConfigMatchResult(
      uriConfig: uriConfig,
      matchedRequiredRouteCount: matchedRequiredRouteCount,
      matchedRequiredFlowStateCount: 1,
    );
  }

  @override
  IList<AppRoute> getRequiredRoutes() {
    return IList<AppRoute>([
      DesktopShoppingListOverviewRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }
}
