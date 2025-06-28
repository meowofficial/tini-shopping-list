import 'package:injectable/injectable.dart';

import '../flow_states/app_initialization_flow_state.dart';
import '../refs/flow_state_refs/app_initialization_flow_state_ref.dart';

abstract interface class AppInitializationFlowStateRefMapper {
  AppInitializationFlowStateRef call(AppInitializationFlowState flowState);
}

@LazySingleton(as: AppInitializationFlowStateRefMapper)
class AppInitializationFlowStateRefMapperImpl implements AppInitializationFlowStateRefMapper {
  const AppInitializationFlowStateRefMapperImpl();

  @override
  AppInitializationFlowStateRef call(AppInitializationFlowState flowState) {
    switch (flowState) {
      case InitialAppInitializationFlowState():
        return const InitialAppInitializationFlowStateRef();

      case LoadingAppInitializationFlowState():
        return const LoadingAppInitializationFlowStateRef();

      case LoadedAppInitializationFlowState():
        return const LoadedAppInitializationFlowStateRef();
    }
  }
}
