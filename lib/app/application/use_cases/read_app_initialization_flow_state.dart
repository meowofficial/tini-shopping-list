import 'package:injectable/injectable.dart';

import '../mappers/shopping_list_overview_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../stores/app_initialization_flow_store.dart';

abstract interface class ReadAppInitializationFlowState {
  AppInitializationFlowStateRef call();
}

@LazySingleton(as: ReadAppInitializationFlowState)
class ReadAppInitializationFlowStateImpl implements ReadAppInitializationFlowState {
  const ReadAppInitializationFlowStateImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
    required AppInitializationFlowStateRefMapper appInitializationFlowStateRefMapper,
  }) : _appInitializationFlowStore = appInitializationFlowStore,
       _appInitializationFlowStateRefMapper = appInitializationFlowStateRefMapper;

  final AppInitializationFlowStore _appInitializationFlowStore;
  final AppInitializationFlowStateRefMapper _appInitializationFlowStateRefMapper;

  @override
  AppInitializationFlowStateRef call() {
    return _appInitializationFlowStateRefMapper(
      _appInitializationFlowStore.state.appInitializationFlowState,
    );
  }
}
