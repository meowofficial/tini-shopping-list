import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/application/stores/base_store.dart';
import '../../../core/common/stream/state_streamable.dart';
import '../flow_states/app_initialization_flow_state.dart';

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

@LazySingleton(as: AppInitializationFlowStore)
class AppInitializationFlowStoreImpl extends BaseStore<AppInitializationFlowStoreState>
    implements AppInitializationFlowStore {
  AppInitializationFlowStoreImpl();

  @override
  void initialize({
    required AppInitializationFlowState appInitializationFlowState,
  }) {
    final initialState = AppInitializationFlowStoreState(
      appInitializationFlowState: appInitializationFlowState,
    );

    initializeState(initialState);
  }

  @override
  void updateWith({
    AppInitializationFlowState Function()? appInitializationFlowState,
  }) {
    final updatedState = state.copyWith(
      appInitializationFlowState: appInitializationFlowState,
    );

    emit(updatedState);
  }
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
