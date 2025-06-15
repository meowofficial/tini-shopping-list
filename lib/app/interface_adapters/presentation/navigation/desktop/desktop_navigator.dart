import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/stream/state_streamable.dart';
import '../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../core/common/typedefs/value_with_previous.dart';
import '../../../../../core/interface_adapters/presentation/navigation/desktop/desktop_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/base_navigator.dart';

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

@LazySingleton(as: DesktopNavigator)
class DesktopNavigatorImpl extends BaseNavigator<DesktopNavigatorState>
    implements DesktopNavigator {
  DesktopNavigatorImpl();

  @override
  late Stream<ValueWithPrevious<DesktopNavigatorState>> stateStreamWithPrevious;

  @override
  void initialize({
    required IList<AppRoute> routes,
    required IMap<AppRoute, DesktopRouteTransition> routeToTransition,
  }) {
    final initialState = DesktopNavigatorState(
      routes: routes,
      routeToTransition: routeToTransition,
    );

    initializeState(initialState);

    stateStreamWithPrevious = stateStream.withPreviousSeeded(initialState);

    emit(initialState);
  }

  @override
  void updateWith({
    IList<AppRoute> Function()? routes,
    IMap<AppRoute, DesktopRouteTransition> Function()? routeToTransition,
  }) {
    final updatedState = state.copyWith(
      routes: routes,
      routeToTransition: routeToTransition,
    );

    emit(updatedState);
  }

  @override
  @disposeMethod
  void dispose() {
    super.dispose();
  }
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
