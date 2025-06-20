import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../common/stream/state_streamable.dart';
import '../../../../common/stream/with_previous_stream.dart';
import '../../../../common/typedefs/value_with_previous.dart';
import '../shared/app_routes.dart';
import '../shared/base_navigator.dart';
import 'phone_home_tab.dart';
import 'phone_route_transition.dart';

abstract interface class PhoneNavigator implements StateStreamable<PhoneNavigatorState> {
  bool get initialized;

  Stream<(PhoneNavigatorState, PhoneNavigatorState)> get stateStreamWithPrevious;

  void initialize({
    required PhoneNavigatorStackState rootStackState,
    required PhoneHomeNavigationState? homeNavigationState,
  });

  void updateWith({
    PhoneNavigatorStackState Function()? rootStackState,
    PhoneHomeNavigationState? Function()? homeNavigationState,
  });

  void dispose();
}

@LazySingleton(as: PhoneNavigator)
class PhoneNavigatorImpl extends BaseNavigator<PhoneNavigatorState> implements PhoneNavigator {
  PhoneNavigatorImpl();

  @override
  late final Stream<ValueWithPrevious<PhoneNavigatorState>> stateStreamWithPrevious;

  @override
  void initialize({
    required PhoneNavigatorStackState rootStackState,
    required PhoneHomeNavigationState? homeNavigationState,
  }) {
    final updatedState = PhoneNavigatorState(
      rootStackState: rootStackState,
      homeNavigationState: homeNavigationState,
    );

    initializeState(updatedState);

    stateStreamWithPrevious = stateStream.withPreviousSeeded(updatedState);
  }

  @override
  void updateWith({
    PhoneNavigatorStackState Function()? rootStackState,
    PhoneHomeNavigationState? Function()? homeNavigationState,
  }) {
    final updatedState = state.copyWith(
      rootStackState: rootStackState,
      homeNavigationState: homeNavigationState,
    );

    emit(updatedState);
  }
}

class PhoneNavigatorStackState extends Equatable {
  const PhoneNavigatorStackState({
    required this.routes,
    required this.routeToTransition,
  });

  final IList<AppRoute> routes;
  final IMap<AppRoute, PhoneRouteTransition> routeToTransition;

  @override
  List<Object?> get props {
    return [
      routes,
      routeToTransition,
    ];
  }

  PhoneNavigatorStackState copyWith({
    IList<AppRoute> Function()? routes,
    IMap<AppRoute, PhoneRouteTransition> Function()? routeToTransition,
  }) {
    return PhoneNavigatorStackState(
      routes: routes == null ? this.routes : routes(),
      routeToTransition: routeToTransition == null ? this.routeToTransition : routeToTransition(),
    );
  }
}

class PhoneNavigatorState extends Equatable {
  const PhoneNavigatorState({
    required this.rootStackState,
    required this.homeNavigationState,
  });

  final PhoneNavigatorStackState rootStackState;
  final PhoneHomeNavigationState? homeNavigationState;

  @override
  List<Object?> get props {
    return [
      rootStackState,
      homeNavigationState,
    ];
  }

  PhoneNavigatorState copyWith({
    PhoneNavigatorStackState Function()? rootStackState,
    PhoneHomeNavigationState? Function()? homeNavigationState,
  }) {
    return PhoneNavigatorState(
      rootStackState: rootStackState == null ? this.rootStackState : rootStackState(),
      homeNavigationState: homeNavigationState == null
          ? this.homeNavigationState
          : homeNavigationState(),
    );
  }
}

class PhoneHomeNavigationState extends Equatable {
  const PhoneHomeNavigationState({
    required this.tabStackStateMap,
    required this.activeTab,
  });

  final IMap<PhoneHomeTab, PhoneNavigatorStackState> tabStackStateMap;
  final PhoneHomeTab activeTab;

  @override
  List<Object?> get props {
    return [
      tabStackStateMap,
      activeTab,
    ];
  }

  PhoneHomeNavigationState copyWith({
    IMap<PhoneHomeTab, PhoneNavigatorStackState> Function()? tabStackStateMap,
    PhoneHomeTab Function()? activeTab,
  }) {
    return PhoneHomeNavigationState(
      tabStackStateMap: tabStackStateMap == null ? this.tabStackStateMap : tabStackStateMap(),
      activeTab: activeTab == null ? this.activeTab : activeTab(),
    );
  }
}
