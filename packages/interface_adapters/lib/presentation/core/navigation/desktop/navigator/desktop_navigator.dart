import 'package:common/stream/state_streamable.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import '../../shared/app_routes.dart';
import '../desktop_route_transition.dart';

abstract interface class DesktopNavigator implements StateStreamable<DesktopNavigatorState> {
  bool get initialized;

  Stream<(DesktopNavigatorState, DesktopNavigatorState)> get stateStreamWithPrevious;

  void initialize({
    required IList<AppRoute> routes,
    required IMap<AppRoute, DesktopRouteTransition> routeToTransition,
  });

  void updateWith({
    IList<AppRoute> Function()? routes,
    IMap<AppRoute, DesktopRouteTransition> Function()? routeToTransition,
  });

  void dispose();
}

class DesktopNavigatorState extends Equatable {
  const DesktopNavigatorState({
    required this.routes,
    required this.routeToTransition,
  });

  final IList<AppRoute> routes;
  final IMap<AppRoute, DesktopRouteTransition> routeToTransition;

  @override
  List<Object?> get props {
    return [
      routes,
      routeToTransition,
    ];
  }

  DesktopNavigatorState copyWith({
    IList<AppRoute> Function()? routes,
    IMap<AppRoute, DesktopRouteTransition> Function()? routeToTransition,
  }) {
    return DesktopNavigatorState(
      routes: routes == null ? this.routes : routes(),
      routeToTransition: routeToTransition == null ? this.routeToTransition : routeToTransition(),
    );
  }
}
