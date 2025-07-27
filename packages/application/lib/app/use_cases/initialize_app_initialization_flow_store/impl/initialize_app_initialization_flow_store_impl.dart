import 'package:injectable/injectable.dart';

import '../../../flow_states/app_initialization_flow_state.dart';
import '../../../stores/app_initialization_flow_store/app_initialization_flow_store.dart';
import '../initialize_app_initialization_flow_store.dart';

@LazySingleton(as: InitializeAppInitializationFlowStore)
class InitializeAppInitializationFlowStoreImpl implements InitializeAppInitializationFlowStore {
  const InitializeAppInitializationFlowStoreImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
  }) : _appInitializationFlowStore = appInitializationFlowStore;

  final AppInitializationFlowStore _appInitializationFlowStore;

  @override
  void call() {
    const appInitializationFlowState = InitialAppInitializationFlowState();

    _appInitializationFlowStore.initialize(
      appInitializationFlowState: appInitializationFlowState,
    );
  }
}
