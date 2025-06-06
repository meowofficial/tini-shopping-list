import 'package:injectable/injectable.dart';

import '../flow_states/app_initialization_flow_state.dart';
import '../mappers/shopping_list_overview_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../stores/app_initialization_store.dart';

abstract interface class ReadAppInitializationFlowState {
  AppInitializationFlowStateRef call();
}

@LazySingleton(as: ReadAppInitializationFlowState)
class ReadAppInitializationFlowStateImpl implements ReadAppInitializationFlowState {
  const ReadAppInitializationFlowStateImpl({
    required AppInitializationStore appInitializationStore,
    required AppInitializationFlowStateRefMapper appInitializationFlowStateRefMapper,
  }) : _appInitializationStore = appInitializationStore,
       _appInitializationFlowStateRefMapper = appInitializationFlowStateRefMapper;
  final AppInitializationStore _appInitializationStore;
  final AppInitializationFlowStateRefMapper _appInitializationFlowStateRefMapper;

  @override
  AppInitializationFlowStateRef call() {
    final appInitializationFlowState = _appInitializationStore.initialized
        ? _appInitializationStore.state.appInitializationFlowState
        : const InitialAppInitializationFlowState();

    return _appInitializationFlowStateRefMapper(appInitializationFlowState);
  }
}
