import 'package:injectable/injectable.dart';

import '../mappers/shopping_list_overview_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../stores/app_initialization_store.dart';

abstract interface class WatchAppInitializationFlowState {
  Stream<AppInitializationFlowStateRef> call();
}

@LazySingleton(as: WatchAppInitializationFlowState)
class WatchAppInitializationFlowStateImpl implements WatchAppInitializationFlowState {
  const WatchAppInitializationFlowStateImpl({
    required AppInitializationStore appInitializationStore,
    required AppInitializationFlowStateRefMapper appInitializationFlowStateRefMapper,
  }) : _appInitializationStore = appInitializationStore,
       _appInitializationFlowStateRefMapper = appInitializationFlowStateRefMapper;
  final AppInitializationStore _appInitializationStore;
  final AppInitializationFlowStateRefMapper _appInitializationFlowStateRefMapper;

  @override
  Stream<AppInitializationFlowStateRef> call() {
    return _appInitializationStore.stateStream.map((state) {
      return _appInitializationFlowStateRefMapper(state.appInitializationFlowState);
    }).distinct();
  }
}
