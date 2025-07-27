import 'package:injectable/injectable.dart';

import '../../../../../flow_states/app_initialization_flow_state.dart';
import '../../../refs/app_initialization_flow_state_ref.dart';
import '../../app_initialization_flow_state_ref_factory/app_initialization_flow_state_ref_factory.dart';

@LazySingleton(as: AppInitializationFlowStateRefFactory)
class AppInitializationFlowStateRefFactoryImpl implements AppInitializationFlowStateRefFactory {
  const AppInitializationFlowStateRefFactoryImpl();

  @override
  AppInitializationFlowStateRef createRef({
    required AppInitializationFlowState flowState,
  }) {
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
