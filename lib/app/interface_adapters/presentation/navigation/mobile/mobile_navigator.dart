import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/common/stream/state_streamable.dart';
import '../../../../../core/common/stream/with_previous_stream.dart';
import '../../../../../core/interface_adapters/presentation/navigation/mobile/mobile_route_transition.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/app_route.dart';
import '../../../../../core/interface_adapters/presentation/navigation/shared/base_navigator.dart';
import '../../../../../features/home/interface_adapters/presentation/mobile_home_tab.dart';

abstract interface class MobileNavigator implements StateStreamable<MobileNavigatorState> {
  Stream<(MobileNavigatorState, MobileNavigatorState)> get stateStreamWithPrevious;

  void initialize({
    required MobileNavigatorStackState rootStackState,
    required IMap<MobileHomeTab, MobileNavigatorStackState> homeTabStackStateMap,
    required MobileHomeTab? activeHomeTab,
  });

  void updateWith({
    MobileNavigatorStackState Function()? rootStackState,
    IMap<MobileHomeTab, MobileNavigatorStackState> Function()? homeTabStackStateMap,
    MobileHomeTab? Function()? activeHomeTab,
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
    required IMap<MobileHomeTab, MobileNavigatorStackState> homeTabStackStateMap,
    required MobileHomeTab? activeHomeTab,
  }) {
    final updatedState = MobileNavigatorState(
      rootStackState: rootStackState,
      homeTabStackStateMap: homeTabStackStateMap,
      activeHomeTab: activeHomeTab,
    );

    initializeState(updatedState);

    stateStreamWithPrevious = stateStream.withPreviousSeeded(updatedState);
  }

  @override
  void updateWith({
    MobileNavigatorStackState Function()? rootStackState,
    IMap<MobileHomeTab, MobileNavigatorStackState> Function()? homeTabStackStateMap,
    MobileHomeTab? Function()? activeHomeTab,
  }) {
    final updatedState = state.copyWith(
      rootStackState: rootStackState,
      homeTabStackStateMap: homeTabStackStateMap,
      activeHomeTab: activeHomeTab,
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
    required this.homeTabStackStateMap,
    required this.activeHomeTab,
  });

  final MobileNavigatorStackState rootStackState;
  final IMap<MobileHomeTab, MobileNavigatorStackState> homeTabStackStateMap;
  final MobileHomeTab? activeHomeTab;

  @override
  List<Object?> get props {
    return [
      rootStackState,
      homeTabStackStateMap,
      activeHomeTab,
    ];
  }

  MobileNavigatorState copyWith({
    MobileNavigatorStackState Function()? rootStackState,
    IMap<MobileHomeTab, MobileNavigatorStackState> Function()? homeTabStackStateMap,
    MobileHomeTab? Function()? activeHomeTab,
  }) {
    return MobileNavigatorState(
      rootStackState: rootStackState == null ? this.rootStackState : rootStackState(),
      homeTabStackStateMap: homeTabStackStateMap == null
          ? this.homeTabStackStateMap
          : homeTabStackStateMap(),
      activeHomeTab: activeHomeTab == null ? this.activeHomeTab : activeHomeTab(),
    );
  }
}
