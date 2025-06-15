import 'package:injectable/injectable.dart';

import '../mappers/shopping_list_overview_flow_state_ref_mapper.dart';
import '../refs/flow_state_refs/app_initialization_flow_state_ref.dart';
import '../stores/app_initialization_flow_store.dart';

abstract interface class WatchAppInitializationFlowState {
  Stream<AppInitializationFlowStateRef> call({
    bool sync = false,
  });
}

@LazySingleton(as: WatchAppInitializationFlowState)
class WatchAppInitializationFlowStateImpl implements WatchAppInitializationFlowState {
  const WatchAppInitializationFlowStateImpl({
    required AppInitializationFlowStore appInitializationFlowStore,
    required AppInitializationFlowStateRefMapper appInitializationFlowStateRefMapper,
  }) : _appInitializationFlowStore = appInitializationFlowStore,
       _appInitializationFlowStateRefMapper = appInitializationFlowStateRefMapper;

  final AppInitializationFlowStore _appInitializationFlowStore;
  final AppInitializationFlowStateRefMapper _appInitializationFlowStateRefMapper;

  @override
  Stream<AppInitializationFlowStateRef> call({
    bool sync = false,
  }) {
    final appInitializationFlowStoreStateStream = sync
        ? _appInitializationFlowStore.syncStateStream
        : _appInitializationFlowStore.stateStream;

    return appInitializationFlowStoreStateStream.map((state) {
      return _appInitializationFlowStateRefMapper(state.appInitializationFlowState);
    }).distinct();
  }
}
