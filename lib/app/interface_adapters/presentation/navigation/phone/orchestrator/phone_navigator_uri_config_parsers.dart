import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:meta/meta.dart';

import '../../../../../../core/common/uuid/uuid_generator.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_app_routes.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/phone/phone_home_tab.dart';
import '../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';
import '../../shared/uri_configs.dart';

class PhoneNavigatorUriConfigMatchResult<T extends UriConfig> extends Equatable {
  const PhoneNavigatorUriConfigMatchResult({
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

sealed class PhoneNavigatorUriConfigParser<T extends UriConfig> {
  IList<AppRoute> getRequiredRootRoutes();

  IList<AppRoute> getRequiredActiveHomeTabRoutes();

  PhoneHomeTab? getRequiredActiveHomeTab();
}

abstract class _BasePhoneNavigatorUriConfigParser<T extends UriConfig> {
  const _BasePhoneNavigatorUriConfigParser();

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
    extends _BasePhoneNavigatorUriConfigParser<ShoppingListOverviewUriConfig>
    implements PhoneNavigatorUriConfigParser<ShoppingListOverviewUriConfig> {
  const ShoppingListOverviewUriConfigParser({
    required UuidGenerator uuidGenerator,
  }) : _uuidGenerator = uuidGenerator;

  final UuidGenerator _uuidGenerator;

  PhoneNavigatorUriConfigMatchResult<ShoppingListOverviewUriConfig>? tryParse({
    required IList<AppRoute> activeRootRoutes,
    required IList<AppRoute> activeHomeTabActiveRoutes,
    required PhoneHomeTab activeHomeTab,
  }) {
    if (activeHomeTab != getRequiredActiveHomeTab()) {
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

    final requiredHomeTabRoutes = getRequiredActiveHomeTabRoutes();

    final matchedHomeTabRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeHomeTabActiveRoutes,
      requiredRoutes: requiredHomeTabRoutes,
    );

    if (matchedHomeTabRouteCount != requiredHomeTabRoutes.length) {
      return null;
    }

    const uriConfig = ShoppingListOverviewUriConfig();

    return PhoneNavigatorUriConfigMatchResult(
      uriConfig: uriConfig,
      matchedRequiredRootRouteCount: matchedRootRouteCount,
      matchedRequiredHomeTabRouteCount: matchedHomeTabRouteCount,
      matchedRequiredFlowStateCount: 0,
    );
  }

  @override
  IList<AppRoute> getRequiredRootRoutes() {
    return IList<AppRoute>([
      PhoneHomeRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  IList<AppRoute> getRequiredActiveHomeTabRoutes() {
    return IList<AppRoute>([
      PhoneShoppingListOverviewRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  PhoneHomeTab getRequiredActiveHomeTab() {
    return PhoneHomeTab.overview;
  }
}

class ShoppingListItemAdditionUriConfigParser
    extends _BasePhoneNavigatorUriConfigParser<ShoppingListItemAdditionUriConfig>
    implements PhoneNavigatorUriConfigParser<ShoppingListItemAdditionUriConfig> {
  const ShoppingListItemAdditionUriConfigParser({
    required UuidGenerator uuidGenerator,
  }) : _uuidGenerator = uuidGenerator;

  final UuidGenerator _uuidGenerator;

  PhoneNavigatorUriConfigMatchResult<ShoppingListItemAdditionUriConfig>? tryParse({
    required IList<AppRoute> activeRootRoutes,
    required IList<AppRoute> activeHomeTabActiveRoutes,
    required PhoneHomeTab activeHomeTab,
  }) {
    if (activeHomeTab != getRequiredActiveHomeTab()) {
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

    final requiredHomeTabRoutes = getRequiredActiveHomeTabRoutes();

    final matchedHomeTabRouteCount = getMatchedRequiredRouteCount(
      activeRoutes: activeHomeTabActiveRoutes,
      requiredRoutes: requiredHomeTabRoutes,
    );

    if (matchedHomeTabRouteCount != requiredHomeTabRoutes.length) {
      return null;
    }

    const uriConfig = ShoppingListItemAdditionUriConfig();

    return PhoneNavigatorUriConfigMatchResult(
      uriConfig: uriConfig,
      matchedRequiredRootRouteCount: matchedRootRouteCount,
      matchedRequiredHomeTabRouteCount: matchedHomeTabRouteCount,
      matchedRequiredFlowStateCount: 0,
    );
  }

  @override
  IList<AppRoute> getRequiredRootRoutes() {
    return IList<AppRoute>([
      PhoneHomeRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  IList<AppRoute> getRequiredActiveHomeTabRoutes() {
    return IList<AppRoute>([
      PhoneShoppingListItemAdditionRoute(
        id: _uuidGenerator.generateUuid(),
      ),
    ]);
  }

  @override
  PhoneHomeTab getRequiredActiveHomeTab() {
    return PhoneHomeTab.addition;
  }
}
