import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/stream/state_streamable.dart';
import '../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/base_navigator.dart';

abstract interface class MobileNavigator implements StateStreamable<MobileNavigatorState> {
  Stream<(MobileNavigatorState, MobileNavigatorState)> get stateStreamWithPrevious;

  void initialize({
    required MobileNavigatorStackState rootStackState,
    required MobileNavigatorStackState overviewTabStackState,
    required MobileNavigatorStackState additionTabStackState,
  });

  void updateWith({
    MobileNavigatorStackState Function()? rootStackState,
    MobileNavigatorStackState Function()? overviewTabStackState,
    MobileNavigatorStackState Function()? additionTabStackState,
  });

  void dispose();
}

@LazySingleton(as: MobileNavigator)
class MobileNavigatorImpl extends BaseNavigator<MobileNavigatorState> implements MobileNavigator {
  MobileNavigatorImpl();

  @override
  late final Stream<(MobileNavigatorState, MobileNavigatorState)> stateStreamWithPrevious;

  @override
  void initialize({
    required MobileNavigatorStackState rootStackState,
    required MobileNavigatorStackState overviewTabStackState,
    required MobileNavigatorStackState additionTabStackState,
  }) {
    final updatedState = MobileNavigatorState(
      rootStackState: rootStackState,
      overviewTabStackState: overviewTabStackState,
      additionTabStackState: additionTabStackState,
    );

    initializeState(updatedState);

    stateStreamWithPrevious = stateStream.withPreviousSeeded(updatedState);
  }

  @override
  void updateWith({
    MobileNavigatorStackState Function()? rootStackState,
    MobileNavigatorStackState Function()? overviewTabStackState,
    MobileNavigatorStackState Function()? additionTabStackState,
  }) {
    final updatedState = state.copyWith(
      rootStackState: rootStackState,
      overviewTabStackState: overviewTabStackState,
      additionTabStackState: additionTabStackState,
    );

    emit(updatedState);
  }
}

class MobileNavigatorStackState extends Equatable {
  const MobileNavigatorStackState({
    required this.routes,
    required this.routeToTransition,
  });

  final IList<AppRoute> routes;
  final IMap<AppRoute, MobileRouteTransition> routeToTransition;

  @override
  List<Object?> get props {
    return [
      routes,
      routeToTransition,
    ];
  }

  MobileNavigatorStackState copyWith({
    IList<AppRoute> Function()? routes,
    IMap<AppRoute, MobileRouteTransition> Function()? routeToTransition,
  }) {
    return MobileNavigatorStackState(
      routes: routes == null ? this.routes : routes(),
      routeToTransition: routeToTransition == null ? this.routeToTransition : routeToTransition(),
    );
  }
}

class MobileNavigatorState extends Equatable {
  const MobileNavigatorState({
    required this.rootStackState,
    required this.overviewTabStackState,
    required this.additionTabStackState,
  });

  final MobileNavigatorStackState rootStackState;
  final MobileNavigatorStackState overviewTabStackState;
  final MobileNavigatorStackState additionTabStackState;

  @override
  List<Object?> get props {
    return [
      rootStackState,
      overviewTabStackState,
      additionTabStackState,
    ];
  }

  MobileNavigatorState copyWith({
    MobileNavigatorStackState Function()? rootStackState,
    MobileNavigatorStackState Function()? overviewTabStackState,
    MobileNavigatorStackState Function()? additionTabStackState,
  }) {
    return MobileNavigatorState(
      rootStackState: rootStackState == null ? this.rootStackState : rootStackState(),
      overviewTabStackState:
          overviewTabStackState == null ? this.overviewTabStackState : overviewTabStackState(),
      additionTabStackState:
          additionTabStackState == null ? this.additionTabStackState : additionTabStackState(),
    );
  }
}
