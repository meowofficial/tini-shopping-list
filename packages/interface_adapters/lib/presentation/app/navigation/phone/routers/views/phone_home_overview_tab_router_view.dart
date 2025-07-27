import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../../../../core/navigation/phone/phone_route_transition.dart';
import '../../../../../core/navigation/shared/app_routes.dart';

class PhoneHomeOverviewTabRouterView extends Equatable {
  const PhoneHomeOverviewTabRouterView({
    required this.routes,
    required this.activeRoutes,
    required this.routeToTransition,
  });

  final IList<AppRoute> routes;
  final IList<AppRoute> activeRoutes;
  final IMap<AppRoute, PhoneRouteTransition> routeToTransition;

  @override
  List<Object?> get props {
    return [
      routes,
      activeRoutes,
      routeToTransition,
    ];
  }

  PhoneHomeOverviewTabRouterView copyWith({
    IList<AppRoute> Function()? routes,
    IList<AppRoute> Function()? activeRoutes,
    IMap<AppRoute, PhoneRouteTransition> Function()? routeToTransition,
  }) {
    return PhoneHomeOverviewTabRouterView(
      routes: routes == null ? this.routes : routes(),
      activeRoutes: activeRoutes == null ? this.activeRoutes : activeRoutes(),
      routeToTransition: routeToTransition == null ? this.routeToTransition : routeToTransition(),
    );
  }
}
