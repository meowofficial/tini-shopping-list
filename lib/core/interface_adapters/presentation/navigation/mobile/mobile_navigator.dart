import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/stream/state_streamable.dart';
import '../../../../common/stream/with_previous_stream.dart';
import '../../../../common/typedefs/value_with_previous.dart';
import '../shared/app_routes.dart';
import '../shared/base_navigator.dart';
import 'mobile_home_tab.dart';
import 'mobile_route_transition.dart';

abstract interface class MobileNavigator implements StateStreamable<MobileNavigatorState> {
  bool get initialized;

  Stream<(MobileNavigatorState, MobileNavigatorState)> get stateStreamWithPrevious;

  void initialize({
    required MobileNavigatorStackState rootStackState,
    required MobileHomeNavigationState? homeNavigationState,
  });

  void updateWith({
    MobileNavigatorStackState Function()? rootStackState,
    MobileHomeNavigationState? Function()? homeNavigationState,
  });

  void dispose();
}

@LazySingleton(as: MobileNavigator)
class MobileNavigatorImpl extends BaseNavigator<MobileNavigatorState> implements MobileNavigator {
  MobileNavigatorImpl();

  @override
  late final Stream<ValueWithPrevious<MobileNavigatorState>> stateStreamWithPrevious;

  @override
  void initialize({
    required MobileNavigatorStackState rootStackState,
    required MobileHomeNavigationState? homeNavigationState,
  }) {
    final updatedState = MobileNavigatorState(
      rootStackState: rootStackState,
      homeNavigationState: homeNavigationState,
    );

    initializeState(updatedState);

    stateStreamWithPrevious = stateStream.withPreviousSeeded(updatedState);
  }

  @override
  void updateWith({
    MobileNavigatorStackState Function()? rootStackState,
    MobileHomeNavigationState? Function()? homeNavigationState,
  }) {
    final updatedState = state.copyWith(
      rootStackState: rootStackState,
      homeNavigationState: homeNavigationState,
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
    required this.homeNavigationState,
  });

  final MobileNavigatorStackState rootStackState;
  final MobileHomeNavigationState? homeNavigationState;

  @override
  List<Object?> get props {
    return [
      rootStackState,
      homeNavigationState,
    ];
  }

  MobileNavigatorState copyWith({
    MobileNavigatorStackState Function()? rootStackState,
    MobileHomeNavigationState? Function()? homeNavigationState,
  }) {
    return MobileNavigatorState(
      rootStackState: rootStackState == null ? this.rootStackState : rootStackState(),
      homeNavigationState: homeNavigationState == null
          ? this.homeNavigationState
          : homeNavigationState(),
    );
  }
}

class MobileHomeNavigationState extends Equatable {
  const MobileHomeNavigationState({
    required this.tabStackStateMap,
    required this.activeTab,
  });

  final IMap<MobileHomeTab, MobileNavigatorStackState> tabStackStateMap;
  final MobileHomeTab activeTab;

  @override
  List<Object?> get props {
    return [
      tabStackStateMap,
      activeTab,
    ];
  }

  MobileHomeNavigationState copyWith({
    IMap<MobileHomeTab, MobileNavigatorStackState> Function()? tabStackStateMap,
    MobileHomeTab Function()? activeTab,
  }) {
    return MobileHomeNavigationState(
      tabStackStateMap: tabStackStateMap == null ? this.tabStackStateMap : tabStackStateMap(),
      activeTab: activeTab == null ? this.activeTab : activeTab(),
    );
  }
}
