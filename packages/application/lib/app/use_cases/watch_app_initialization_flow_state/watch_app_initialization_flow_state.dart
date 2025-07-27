import '../shared/refs/app_initialization_flow_state_ref.dart';

abstract interface class WatchAppInitializationFlowState {
  Stream<AppInitializationFlowStateRef> call({
    bool sync = false,
  });
}
