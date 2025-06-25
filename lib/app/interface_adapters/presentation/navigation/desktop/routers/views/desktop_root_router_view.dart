import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_route_transition.dart';
import '../../../../../../../core/interface_adapters/presentation/navigation/shared/app_routes.dart';

class DesktopRootRouterView extends Equatable {
  const DesktopRootRouterView({
    required this.routes,
    required this.activeRoutes,
    required this.routeToTransition,
  });

  final IList<AppRoute> routes;
  final IList<AppRoute> activeRoutes;
  final IMap<AppRoute, DesktopRouteTransition> routeToTransition;

  @override
  List<Object?> get props {
    return [
      routes,
      activeRoutes,
      routeToTransition,
    ];
  }

  DesktopRootRouterView copyWith({
    IList<AppRoute> Function()? routes,
    IList<AppRoute> Function()? activeRoutes,
    IMap<AppRoute, DesktopRouteTransition> Function()? routeToTransition,
  }) {
    return DesktopRootRouterView(
      routes: routes == null ? this.routes : routes(),
      activeRoutes: activeRoutes == null ? this.activeRoutes : activeRoutes(),
      routeToTransition: routeToTransition == null ? this.routeToTransition : routeToTransition(),
    );
  }
}
