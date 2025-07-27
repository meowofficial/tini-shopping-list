import 'package:common/stream/state_streamable.dart';
import 'package:equatable/equatable.dart';

import '../../flow_states/app_initialization_flow_state.dart';

abstract interface class AppInitializationFlowStore
    implements StateStreamable<AppInitializationFlowStoreState> {
  bool get initialized;

  void initialize({
    required AppInitializationFlowState appInitializationFlowState,
  });

  void updateWith({
    AppInitializationFlowState Function()? appInitializationFlowState,
  });

  void dispose();
}

class AppInitializationFlowStoreState extends Equatable {
  const AppInitializationFlowStoreState({
    required this.appInitializationFlowState,
  });

  final AppInitializationFlowState appInitializationFlowState;

  @override
  List<Object?> get props {
    return [
      appInitializationFlowState,
    ];
  }

  AppInitializationFlowStoreState copyWith({
    AppInitializationFlowState Function()? appInitializationFlowState,
  }) {
    return AppInitializationFlowStoreState(
      appInitializationFlowState: appInitializationFlowState == null
          ? this.appInitializationFlowState
          : appInitializationFlowState(),
    );
  }
}
