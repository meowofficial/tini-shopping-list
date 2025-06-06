import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../core/application/stores/base_store.dart';
import '../../../core/common/stream/state_streamable.dart';
import '../flow_states/app_initialization_flow_state.dart';

abstract interface class AppInitializationStore
    implements StateStreamable<AppInitializationStoreState> {
  bool get initialized;

  void initialize({
    required AppInitializationFlowState appInitializationFlowState,
  });

  void updateWith({
    AppInitializationFlowState Function()? appInitializationFlowState,
  });

  void dispose();
}

@LazySingleton(as: AppInitializationStore)
class AppInitializationStoreImpl extends BaseStore<AppInitializationStoreState>
    implements AppInitializationStore {
  AppInitializationStoreImpl();

  @override
  void initialize({
    required AppInitializationFlowState appInitializationFlowState,
  }) {
    final initialState = AppInitializationStoreState(
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

class AppInitializationStoreState extends Equatable {
  const AppInitializationStoreState({
    required this.appInitializationFlowState,
  });

  final AppInitializationFlowState appInitializationFlowState;

  @override
  List<Object?> get props {
    return [
      appInitializationFlowState,
    ];
  }

  AppInitializationStoreState copyWith({
    AppInitializationFlowState Function()? appInitializationFlowState,
  }) {
    return AppInitializationStoreState(
      appInitializationFlowState: appInitializationFlowState == null
          ? this.appInitializationFlowState
          : appInitializationFlowState(),
    );
  }
}
