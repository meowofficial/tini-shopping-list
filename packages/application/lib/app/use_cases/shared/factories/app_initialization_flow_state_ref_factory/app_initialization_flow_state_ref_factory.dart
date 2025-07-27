import '../../../../flow_states/app_initialization_flow_state.dart';
import '../../refs/app_initialization_flow_state_ref.dart';

abstract interface class AppInitializationFlowStateRefFactory {
  AppInitializationFlowStateRef createRef({
    required AppInitializationFlowState flowState,
  });
}
